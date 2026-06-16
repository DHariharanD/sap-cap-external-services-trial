package customer.sap_cap_external_services_trial;

import com.sap.cds.services.handler.EventHandler;
import com.sap.cds.services.handler.annotations.On;
import com.sap.cds.services.handler.annotations.ServiceName;
import com.sap.cds.services.cds.CqnService;
import com.sap.cds.services.cds.CdsReadEventContext;
import com.sap.cds.ql.cqn.CqnAnalyzer;
import com.sap.cds.ResultBuilder;

import static com.sap.cds.ResultBuilder.selectedRows;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

import java.io.ByteArrayInputStream;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.nio.charset.StandardCharsets;
import java.util.*;
import java.util.zip.GZIPInputStream;
import java.util.zip.Inflater;
import java.util.zip.InflaterInputStream;

import cds.gen.procurementservice.*;

@Component
@ServiceName(ProcurementService_.CDS_NAME)
public class ProcurementServiceHandler implements EventHandler {

    private static final Logger log = LoggerFactory.getLogger(ProcurementServiceHandler.class);

    private static final String PO_BASE = "https://sandbox.api.sap.com/s4hanacloud/sap/opu/odata4/sap/api_purchaseorder_2/srvd_a2x/sap/purchaseorder/0001";
    private static final String PR_BASE = "https://sandbox.api.sap.com/s4hanacloud/sap/opu/odata4/sap/api_purchaserequisition_2/srvd_a2x/sap/purchaserequisition/0001";

    @Value("${SAP_API_KEY}")
    private String apiKey;

    private final HttpClient   httpClient = HttpClient.newHttpClient();
    private final ObjectMapper mapper     = new ObjectMapper();

    private List<Map<String, Object>> fetchFromRemote(String baseUrl, String entity) {
        String url = baseUrl + "/" + entity + "?$top=50&$count=true";
        log.info("Fetching from SAP API → {}", url);

        try {
            HttpRequest request = HttpRequest.newBuilder()
                .uri(URI.create(url))
                .header("apikey", apiKey)
                .header("Accept", "application/json")
                .GET()
                .build();

            HttpResponse<byte[]> response = httpClient.send(request, HttpResponse.BodyHandlers.ofByteArray());

            int statusCode = response.statusCode();
            log.info("SAP API [{}] → HTTP {}", entity, statusCode);

            byte[] body = response.body();
            String contentEncoding = response.headers().firstValue("content-encoding").orElse("");

            String json;
            if (contentEncoding.contains("deflate")) {
                InflaterInputStream inflater = new InflaterInputStream(
                    new ByteArrayInputStream(body), new Inflater(true));
                json = new String(inflater.readAllBytes(), StandardCharsets.UTF_8);
            } else if (contentEncoding.contains("gzip")) {
                GZIPInputStream gzip = new GZIPInputStream(new ByteArrayInputStream(body));
                json = new String(gzip.readAllBytes(), StandardCharsets.UTF_8);
            } else {
                json = new String(body, StandardCharsets.UTF_8);
            }

            // If the sandbox returns a non-200 (e.g. 401 Unauthorized, 403 Forbidden),
            // log the full response body so you can see the exact error message,
            // then throw so CAP surfaces a proper 500 instead of silently returning no data.
            if (statusCode != 200) {
                log.error("SAP API error for [{}] — HTTP {} — body: {}", entity, statusCode, json);
                throw new RuntimeException(
                    "SAP sandbox returned HTTP " + statusCode + " for entity [" + entity + "]. "
                    + "Check your API key and make sure the API is activated on api.sap.com. "
                    + "Response: " + json);
            }

            JsonNode root   = mapper.readTree(json);
            JsonNode values = root.get("value");

            if (values == null || !values.isArray()) {
                // 200 but no "value" array — log the full body to help diagnose
                log.warn("SAP API [{}] returned 200 but no 'value' array. Body: {}", entity, json);
                return Collections.emptyList();
            }

            List<Map<String, Object>> result = new ArrayList<>();
            for (JsonNode node : values) {
                result.add(mapper.convertValue(node, Map.class));
            }

            log.info("SAP API [{}] → {} record(s) fetched", entity, result.size());
            return result;

        } catch (RuntimeException e) {
            // Re-throw RuntimeExceptions as-is (includes our status-check throw above)
            throw e;
        } catch (Exception e) {
            log.error("Failed to fetch [{}] from SAP API: {}", entity, e.getMessage(), e);
            throw new RuntimeException("Failed to fetch " + entity + ": " + e.getMessage(), e);
        }
    }

    // ── Purchase Orders ───────────────────────────────────────────────────────
    @On(event = CqnService.EVENT_READ, entity = PurchaseOrders_.CDS_NAME)
    public void onReadPurchaseOrders(CdsReadEventContext context) {
        List<Map<String, Object>> data = fetchFromRemote(PO_BASE, "PurchaseOrder");
        if (CqnAnalyzer.isCountQuery(context.getCqn())) {
            context.setResult(List.of(Collections.singletonMap("count", data.size())));
        } else {
            context.setResult(selectedRows(data).inlineCount(data.size()).result());
        }
        context.setCompleted();
    }

    @On(event = CqnService.EVENT_READ, entity = PurchaseOrderItems_.CDS_NAME)
    public void onReadPurchaseOrderItems(CdsReadEventContext context) {
        List<Map<String, Object>> data = fetchFromRemote(PO_BASE, "PurchaseOrderItem");
        if (CqnAnalyzer.isCountQuery(context.getCqn())) {
            context.setResult(List.of(Collections.singletonMap("count", data.size())));
        } else {
            context.setResult(selectedRows(data).inlineCount(data.size()).result());
        }
        context.setCompleted();
    }

    // ── Purchase Requisitions ─────────────────────────────────────────────────
    @On(event = CqnService.EVENT_READ, entity = PurchaseRequisitions_.CDS_NAME)
    public void onReadPurchaseRequisitions(CdsReadEventContext context) {
        List<Map<String, Object>> data = fetchFromRemote(PR_BASE, "PurchaseReqn");
        if (CqnAnalyzer.isCountQuery(context.getCqn())) {
            context.setResult(List.of(Collections.singletonMap("count", data.size())));
        } else {
            context.setResult(selectedRows(data).inlineCount(data.size()).result());
        }
        context.setCompleted();
    }

    @On(event = CqnService.EVENT_READ, entity = PurchaseRequisitionItems_.CDS_NAME)
    public void onReadPurchaseRequisitionItems(CdsReadEventContext context) {
        List<Map<String, Object>> data = fetchFromRemote(PR_BASE, "PurchaseReqnItem");
        if (CqnAnalyzer.isCountQuery(context.getCqn())) {
            context.setResult(List.of(Collections.singletonMap("count", data.size())));
        } else {
            context.setResult(selectedRows(data).inlineCount(data.size()).result());
        }
        context.setCompleted();
    }
}