using { CE_PURCHASEORDER_0001 as PO_API } from './external/CE_PURCHASEORDER_0001';
using { CE_PURCHASEREQUISITION_0001 as PR_API } from './external/CE_PURCHASEREQUISITION_0001';

service ProcurementService @(path: '/procurement') {

    // ── Purchase Orders ──────────────────────────────────────────
    @readonly
    entity PurchaseOrders as projection on PO_API.PurchaseOrder {
        PurchaseOrder,
        PurchaseOrderType,
        Supplier,
        CompanyCode,
        PurchasingOrganization,
        PurchasingGroup,
        DocumentCurrency,
        CreationDate,
        PurchaseOrderDate,
        PurchasingProcessingStatus,
        PurchaseOrderDeletionCode,
        PaymentTerms,
        Language,
        ReleaseIsNotCompleted,
        CreatedByUser,
        LastChangeDateTime
    };

    @readonly
    entity PurchaseOrderItems as projection on PO_API.PurchaseOrderItem {
        PurchaseOrder,
        PurchaseOrderItem,
        Material,
        MaterialGroup,
        MaterialType,
        PurchaseOrderItemText,
        CompanyCode,
        Plant,
        StorageLocation,
        OrderQuantity,
        PurchaseOrderQuantityUnit,
        NetPriceAmount,
        NetAmount,
        GrossAmount,
        DocumentCurrency,
        AccountAssignmentCategory,
        IsCompletelyDelivered,
        IsFinallyInvoiced,
        GoodsReceiptIsExpected,
        InvoiceIsExpected,
        PlannedDeliveryDurationInDays,
        PurchaseRequisition,
        IsReturnsItem,
        ItemGrossWeight,
        ItemNetWeight,
        ItemWeightUnit
    };

    // ── Purchase Requisitions ─────────────────────────────────────
    entity PurchaseRequisitions as projection on PR_API.PurchaseReqn {
        PurchaseRequisition,
        PurchaseRequisitionType,
        PurReqnDescription,
        SourceDetermination,
        PurReqnDoOnlyValidation
    };

    entity PurchaseRequisitionItems as projection on PR_API.PurchaseReqnItem {
        PurchaseRequisition,
        PurchaseRequisitionItem,
        PurchaseRequisitionItemText,
        Material,
        MaterialGroup,
        RequestedQuantity,
        BaseUnit,
        PurchaseRequisitionPrice,
        PurReqnItemCurrency,
        ItemNetAmount,
        DeliveryDate,
        Supplier,
        Plant,
        PurchasingOrganization,
        PurchasingGroup,
        CompanyCode,
        PurReqnReleaseStatus,
        ProcessingStatus,
        CreatedByUser,
        PurReqCreationDate,
        LastChangeDateTime,
        IsDeleted,
        IsClosed,
        ReleaseIsNotCompleted,
        GoodsReceiptIsExpected,
        StorageLocation
    };

}