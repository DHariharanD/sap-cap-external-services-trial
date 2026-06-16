package customer.sap_cap_external_services_trial;

import com.sap.cds.services.handler.EventHandler;
import com.sap.cds.services.handler.annotations.On;
import com.sap.cds.services.handler.annotations.ServiceName;
import com.sap.cds.services.cds.CqnService;
import com.sap.cds.services.cds.CdsReadEventContext;
import com.sap.cds.ql.cqn.CqnAnalyzer;

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

    private static final String PO_BASE = "https://sandbox.api.sap.com/s4hanacloud/sap/opu/odata4/sap/api_purchaseorder_2/srvd_a2x/sap/purchaseorder/0001";
    private static final String PR_BASE = "https://sandbox.api.sap.com/s4hanacloud/sap/opu/odata4/sap/api_purchaserequisition_2/srvd_a2x/sap/purchaserequisition/0001";
    private static final String API_KEY = "<ENTER_YOUR_API_KEY>";

    private final HttpClient   httpClient = HttpClient.newHttpClient();
    private final ObjectMapper mapper     = new ObjectMapper();

    private List<Map<String, Object>> fetchFromRemote(String baseUrl, String entity) {
        try {
            String url = baseUrl + "/" + entity + "?$top=50&$count=true";

            HttpRequest request = HttpRequest.newBuilder()
                .uri(URI.create(url))
                .header("apikey", API_KEY)
                .header("Accept", "application/json")
                .GET()
                .build();

            HttpResponse<byte[]> response = httpClient.send(request, HttpResponse.BodyHandlers.ofByteArray());

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

            JsonNode root   = mapper.readTree(json);
            JsonNode values = root.get("value");

            List<Map<String, Object>> result = new ArrayList<>();
            if (values != null && values.isArray()) {
                for (JsonNode node : values) {
                    result.add(mapper.convertValue(node, Map.class));
                }
            }
            return result;

        } catch (Exception e) {
            throw new RuntimeException("Failed to fetch " + entity + ": " + e.getMessage(), e);
        }
    }

    // ── Purchase Orders ───────────────────────────────────────────
    @On(event = CqnService.EVENT_READ, entity = PurchaseOrders_.CDS_NAME)
    public void onReadPurchaseOrders(CdsReadEventContext context) {
        List<Map<String, Object>> data = fetchFromRemote(PO_BASE, "PurchaseOrder");
        if (CqnAnalyzer.isCountQuery(context.getCqn())) {
            context.setResult(List.of(Collections.singletonMap("count", data.size())));
        } else {
            context.setResult(data);
        }
        context.setCompleted();
    }

    @On(event = CqnService.EVENT_READ, entity = PurchaseOrderItems_.CDS_NAME)
    public void onReadPurchaseOrderItems(CdsReadEventContext context) {
        List<Map<String, Object>> data = fetchFromRemote(PO_BASE, "PurchaseOrderItem");
        if (CqnAnalyzer.isCountQuery(context.getCqn())) {
            context.setResult(List.of(Collections.singletonMap("count", data.size())));
        } else {
            context.setResult(data);
        }
        context.setCompleted();
    }

    @On(event = CqnService.EVENT_READ, entity = PurchaseRequisitions_.CDS_NAME)
    public void onReadPurchaseRequisitions(CdsReadEventContext context) {
        List<Map<String, Object>> data = fetchFromRemote(PR_BASE, "PurchaseReqn");
        if (CqnAnalyzer.isCountQuery(context.getCqn())) {
            context.setResult(List.of(Collections.singletonMap("count", data.size())));
        } else {
            context.setResult(data);
        }
        context.setCompleted();
    }

    @On(event = CqnService.EVENT_READ, entity = PurchaseRequisitionItems_.CDS_NAME)
    public void onReadPurchaseRequisitionItems(CdsReadEventContext context) {
        List<Map<String, Object>> data = fetchFromRemote(PR_BASE, "PurchaseReqnItem");
        if (CqnAnalyzer.isCountQuery(context.getCqn())) {
            context.setResult(List.of(Collections.singletonMap("count", data.size())));
        } else {
            context.setResult(data);
        }
        context.setCompleted();
    }
}