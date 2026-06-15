/* checksum : 11ff7a76247c246a630ab595b354f216 */
@cds.external : true
@CodeList.CurrencyCodes.Url : '../../../../default/iwbep/common/0001/$metadata'
@CodeList.CurrencyCodes.CollectionPath : 'Currencies'
@CodeList.UnitsOfMeasure.Url : '../../../../default/iwbep/common/0001/$metadata'
@CodeList.UnitsOfMeasure.CollectionPath : 'UnitsOfMeasure'
@Common.ApplyMultiUnitBehaviorForSortingAndFiltering : true
@Capabilities.FilterFunctions : [
  'eq',
  'ne',
  'gt',
  'ge',
  'lt',
  'le',
  'and',
  'or',
  'contains',
  'startswith',
  'endswith',
  'any',
  'all'
]
@SAP__support.TechnicalInfoLinks.Url : '../../../../default/iwbep/common/0001/$metadata'
@SAP__support.TechnicalInfoLinks.FunctionImport : 'GetTechnicalInfoLinks'
@Capabilities.SupportedFormats : [ 'application/json', 'application/pdf' ]
@PDF.Features.DocumentDescriptionReference : '../../../../default/iwbep/common/0001/$metadata'
@PDF.Features.DocumentDescriptionCollection : 'MyDocumentDescriptions'
@PDF.Features.ArchiveFormat : true
@PDF.Features.Border : true
@PDF.Features.CoverPage : true
@PDF.Features.FitToPage : true
@PDF.Features.FontName : true
@PDF.Features.FontSize : true
@PDF.Features.HeaderFooter : true
@PDF.Features.IANATimezoneFormat : true
@PDF.Features.Margin : true
@PDF.Features.Padding : true
@PDF.Features.ResultSizeDefault : 20000
@PDF.Features.ResultSizeMaximum : 20000
@PDF.Features.Signature : true
@PDF.Features.TextDirectionLayout : true
@PDF.Features.Treeview : true
@PDF.Features.UploadToFileShare : true
@Capabilities.KeyAsSegmentSupported : true
@Capabilities.AsynchronousRequestsSupported : true
service CE_PURCHASEREQUISITION_0001 {
  @cds.external : true
  type SAP__Message {
    code : String not null;
    message : String not null;
    target : String;
    additionalTargets : many String not null;
    transition : Boolean not null;
    @odata.Type : 'Edm.Byte'
    numericSeverity : Integer not null;
    longtextUrl : String;
  };

  @cds.external : true
  @cds.persistence.skip : true
  @Common.Label : 'Purchase Requisition'
  @Common.SemanticKey : [ 'PurchaseRequisition' ]
  @Common.Messages : SAP__Messages
  @Capabilities.SearchRestrictions.Searchable : false
  @Capabilities.FilterRestrictions.Filterable : true
  @Capabilities.FilterRestrictions.FilterExpressionRestrictions : [
    { Property: PurReqnHeaderNote, AllowedExpressions: 'SearchExpression' }
  ]
  @Capabilities.FilterRestrictions.NonFilterableProperties : [ 'PurReqnHeaderNote' ]
  @Capabilities.SortRestrictions.NonSortableProperties : [ 'PurReqnHeaderNote' ]
  @Capabilities.UpdateRestrictions.DeltaUpdateSupported : true
  @Capabilities.UpdateRestrictions.NonUpdatableNavigationProperties : [ '_PurchaseRequisitionItem' ]
  @Capabilities.UpdateRestrictions.QueryOptions.SelectSupported : true
  @Capabilities.DeepUpdateSupport.ContentIDSupported : true
  @Capabilities.DeleteRestrictions.Deletable : false
  @Core.OptimisticConcurrency : true
  entity PurchaseReqn {
    @Core.ComputedDefaultValue : true
    @Common.IsUpperCase : true
    @Common.Label : 'Purchase Requisition'
    @Common.Heading : 'Purch.Reqn'
    @Common.QuickInfo : 'Purchase Requisition Number'
    key PurchaseRequisition : String(10) not null;
    @Common.SAPObjectNodeTypeReference : 'PurchaseRequisitionType'
    @Common.IsUpperCase : true
    @Common.Label : 'Document Type'
    @Common.QuickInfo : 'Purchase Requisition Document Type'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=BBSRT'
    PurchaseRequisitionType : String(4) not null;
    @Common.Label : 'PurReqn Description'
    @Common.Heading : 'Purchase Requisition Description'
    @Common.QuickInfo : 'Purchase Requisition Description'
    PurReqnDescription : String(40) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Long Text'
    PurReqnHeaderNote : String not null;
    @Common.Label : 'Checkbox'
    SourceDetermination : Boolean not null;
    @Common.Label : 'Boolean Variable (X = True, - = False, Space = Unknown)'
    PurReqnDoOnlyValidation : Boolean not null;
    SAP__Messages : many SAP__Message not null;
    @Common.Composition : true
    _PurchaseRequisitionItem : Composition of many PurchaseReqnItem on _PurchaseRequisitionItem._PurReqn = $self;
  } actions {
    action Validate();
    action EnablePurReqForPurchasing();
    action DiscardPurReqFromPurchasing();
  };

  @cds.external : true
  @cds.persistence.skip : true
  @Common.Label : 'Account Assignment'
  @Common.SemanticKey : [
    'PurchaseReqnAcctAssgmtNumber',
    'PurchaseRequisitionItem',
    'PurchaseRequisition'
  ]
  @Common.Messages : SAP__Messages
  @Capabilities.NavigationRestrictions.RestrictedProperties : [
    {
      NavigationProperty: _PurchaseRequisitionItem,
      InsertRestrictions: { Insertable: false },
      DeepUpdateSupport: { Supported: false }
    },
    {
      NavigationProperty: _PurReqn,
      InsertRestrictions: { Insertable: false },
      DeepUpdateSupport: { Supported: false }
    }
  ]
  @Capabilities.SearchRestrictions.Searchable : false
  @Capabilities.FilterRestrictions.NonFilterableProperties : [ 'NetworkActivity' ]
  @Capabilities.SortRestrictions.NonSortableProperties : [ 'NetworkActivity' ]
  @Capabilities.UpdateRestrictions.DeltaUpdateSupported : true
  @Capabilities.UpdateRestrictions.NonUpdatableNavigationProperties : [ '_PurchaseRequisitionItem', '_PurReqn' ]
  @Capabilities.UpdateRestrictions.QueryOptions.SelectSupported : true
  @Capabilities.DeepUpdateSupport.ContentIDSupported : true
  @Capabilities.DeleteRestrictions.Deletable : false
  @Core.OptimisticConcurrency : true
  entity PurchaseReqnAcctAssgmt {
    @Core.ComputedDefaultValue : true
    @Common.IsUpperCase : true
    @Common.Label : 'Purchase Requisition'
    @Common.Heading : 'Purch.Req.'
    @Common.QuickInfo : 'Purchase Requisition Number'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=BANFN'
    key PurchaseRequisition : String(10) not null;
    @Core.ComputedDefaultValue : true
    @Common.IsDigitSequence : true
    @Common.Label : 'Item of requisition'
    @Common.Heading : 'Item'
    @Common.QuickInfo : 'Item Number of Purchase Requisition'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=BNFPO'
    key PurchaseRequisitionItem : String(5) not null;
    @Core.Computed : true
    @Common.IsDigitSequence : true
    @Common.Label : 'Serial no.acct.assgt'
    @Common.Heading : 'Ser'
    @Common.QuickInfo : 'Serial number for PReq account assignment segment'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=DZEBKN'
    key PurchaseReqnAcctAssgmtNumber : String(2) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Cost Center'
    @Common.Heading : 'Cost Ctr'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=KOSTL'
    CostCenter : String(10) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Asset'
    @Common.QuickInfo : 'Main Asset Number'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=ANLN1'
    MasterFixedAsset : String(12) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Network'
    @Common.QuickInfo : 'Network Number for Account Assignment'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=NPLNR'
    ProjectNetwork : String(12) not null;
    @Common.IsUnit : true
    @Common.Label : 'Unit of Measure'
    @Common.Heading : 'Un'
    @Common.QuickInfo : 'Purchase requisition unit of measure'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=BAMEI'
    BaseUnit : String(3) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'ISO Code'
    @Common.Heading : 'ISO'
    @Common.QuickInfo : 'ISO Code for Unit of Measurement'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=ISOCD_UNIT'
    BaseUnitISOCode : String(3) not null;
    @Measures.Unit : BaseUnit
    @Measures.UNECEUnit : BaseUnitISOCode
    @Common.Label : 'Quantity requested'
    @Common.Heading : 'Qty requested'
    @Common.QuickInfo : 'Purchase requisition quantity'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=BAMNG'
    Quantity : Decimal(13, 3) not null;
    @Common.Label : 'Distribution (%)'
    @Common.Heading : 'Percent'
    @Common.QuickInfo : 'Distribution percentage in the case of multiple acct assgt'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=VPROZ'
    MultipleAcctAssgmtDistrPercent : Decimal(3, 1) not null;
    @Common.IsCurrency : true
    @Common.IsUpperCase : true
    @Common.Label : 'Currency'
    @Common.Heading : 'Crcy'
    @Common.QuickInfo : 'Currency Key'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=WAERS'
    PurReqnItemCurrency : String(3) not null;
    @Measures.ISOCurrency : PurReqnItemCurrency
    @Common.Label : 'Net Order Value'
    @Common.Heading : 'Net Value'
    @Common.QuickInfo : 'Net Order Value in PO Currency'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=BWERT'
    PurReqnNetAmount : Decimal(precision: 13) not null;
    @Common.Label : 'Deletion Indicator'
    @Common.Heading : 'D'
    @Common.QuickInfo : 'Deletion Indicator in Purchasing Document'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=ELOEK'
    IsDeleted : Boolean not null;
    @Common.IsUpperCase : true
    @Common.Label : 'G/L Account'
    @Common.Heading : 'G/L Acct'
    @Common.QuickInfo : 'G/L Account Number'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=SAKNR'
    GLAccount : String(10) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Business Area'
    @Common.Heading : 'BusA'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=GSBER'
    BusinessArea : String(4) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'SD Document'
    @Common.Heading : 'Document'
    @Common.QuickInfo : 'Sales and Distribution Document Number'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=VBELN'
    SalesOrder : String(10) not null;
    @Common.IsDigitSequence : true
    @Common.Label : 'Sales Document Item'
    @Common.Heading : 'SDItem'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=POSNR_VA'
    SalesOrderItem : String(6) not null;
    @Common.IsDigitSequence : true
    @Common.Label : 'Schedule Line Number'
    @Common.Heading : 'SLNo'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=ETENR'
    SalesOrderScheduleLine : String(4) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Subnumber'
    @Common.Heading : 'SNo.'
    @Common.QuickInfo : 'Asset Subnumber'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=ANLN2'
    FixedAsset : String(4) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Order'
    @Common.QuickInfo : 'Order Number'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=AUFNR'
    OrderID : String(12) not null;
    @Common.Label : 'Unloading Point'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=ABLAD'
    UnloadingPointName : String(25) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Controlling Area'
    @Common.Heading : 'COAr'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=KOKRS'
    ControllingArea : String(4) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Cost Object'
    @Common.Heading : 'CostObject'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=KSTRG'
    CostObject : String(12) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Profit Center'
    @Common.Heading : 'Profit Ctr'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=PRCTR'
    ProfitCenter : String(10) not null;
    @Common.IsDigitSequence : true
    @Common.Label : 'Opertn Task List No.'
    @Common.Heading : 'Routing Number for Operations'
    @Common.QuickInfo : 'Routing Number of Operations in the Order'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=CO_AUFPL'
    ProjectNetworkInternalID : String(10) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Commitment Item'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=FM_FIPEX'
    CommitmentItem : String(24) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Funds Center'
    @Common.Heading : 'Funds Ctr'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=FISTL'
    FundsCenter : String(16) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Fund'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=BP_GEBER'
    Fund : String(10) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Functional Area'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=FKBER'
    FunctionalArea : String(16) not null;
    @Common.Label : 'Created On'
    @Common.QuickInfo : 'Record Creation Date'
    CreationDate : Date;
    @Common.Label : 'Goods Recipient'
    @Common.Heading : 'Recipient'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=WEMPF'
    GoodsRecipientName : String(12) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Real Estate Key'
    @Common.QuickInfo : 'Internal Key of Real Estate Object (FI)'
    REInternalFinNumber : String(8) not null;
    @Common.IsDigitSequence : true
    @Common.Label : 'Counter'
    @Common.QuickInfo : 'Internal counter'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=CIM_COUNT'
    NetworkActivityInternalID : String(8) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Partner'
    @Common.QuickInfo : 'Partner account number'
    PartnerAccountNumber : String(10) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Recovery Indicator'
    @Common.Heading : 'RI'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=JV_RECIND'
    JointVentureRecoveryCode : String(2) not null;
    @Common.Label : 'Reference Date'
    @Common.Heading : 'Ref date'
    @Common.QuickInfo : 'Reference date for settlement'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=DABRBEZ'
    SettlementReferenceDate : Date;
    @Common.IsDigitSequence : true
    @Common.Label : 'Opertn Task List No.'
    @Common.Heading : 'Routing Number for Operations'
    @Common.QuickInfo : 'Routing Number of Operations in the Order'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=CO_AUFPL'
    OrderInternalID : String(10) not null;
    @Common.IsDigitSequence : true
    @Common.Label : 'Counter'
    @Common.QuickInfo : 'General counter for order'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=CO_APLZL'
    OrderIntBillOfOperationsItem : String(8) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Earmarked Funds'
    @Common.Heading : 'Earm. Fnds'
    @Common.QuickInfo : 'Document Number for Earmarked Funds'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=KBLNR'
    EarmarkedFundsDocument : String(10) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Activity Type'
    @Common.Heading : 'ActTyp'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=LSTAR'
    CostCtrActivityType : String(6) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Business Process'
    @Common.Heading : 'Bus. Process'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=CO_PRZNR'
    BusinessProcess : String(12) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Grant'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=GM_GRANT_NBR'
    GrantID : String(20) not null;
    ValidityDate : Date;
    @Common.IsUpperCase : true
    @Common.Label : 'Chart of Accounts'
    ChartOfAccounts : String(4) not null;
    WBSElementExternalID : String(24) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Oper./Act.'
    @Common.Heading : 'Operation/Activity Number'
    @Common.QuickInfo : 'Operation/Activity Number'
    NetworkActivity : String(4) not null;
    SAP__Messages : many SAP__Message not null;
    _PurchaseRequisitionItem : Association to one PurchaseReqnItem on _PurchaseRequisitionItem.PurchaseRequisitionItem = PurchaseRequisitionItem;
    _PurReqn : Association to one PurchaseReqn on _PurReqn.PurchaseRequisition = PurchaseRequisition;
  };

  @cds.external : true
  @cds.persistence.skip : true
  @Common.Label : 'Delivery Address'
  @Common.SemanticKey : [ 'PurchaseRequisitionItem', 'PurchaseRequisition' ]
  @Common.Messages : SAP__Messages
  @Capabilities.NavigationRestrictions.RestrictedProperties : [
    {
      NavigationProperty: _PurchaseRequisitionItem,
      InsertRestrictions: { Insertable: false },
      DeepUpdateSupport: { Supported: false }
    },
    {
      NavigationProperty: _PurReqn,
      InsertRestrictions: { Insertable: false },
      DeepUpdateSupport: { Supported: false }
    }
  ]
  @Capabilities.SearchRestrictions.Searchable : false
  @Capabilities.UpdateRestrictions.DeltaUpdateSupported : true
  @Capabilities.UpdateRestrictions.NonUpdatableNavigationProperties : [ '_PurchaseRequisitionItem', '_PurReqn' ]
  @Capabilities.UpdateRestrictions.QueryOptions.SelectSupported : true
  @Capabilities.DeepUpdateSupport.ContentIDSupported : true
  @Capabilities.InsertRestrictions.Insertable : false
  @Capabilities.DeleteRestrictions.Deletable : false
  @Core.OptimisticConcurrency : true
  entity PurchaseReqnDelivAddress {
    @Core.ComputedDefaultValue : true
    @Common.IsUpperCase : true
    @Common.Label : 'Purchase Requisition'
    @Common.Heading : 'Purch.Reqn'
    @Common.QuickInfo : 'Purchase Requisition Number'
    key PurchaseRequisition : String(10) not null;
    @Core.ComputedDefaultValue : true
    @Common.IsDigitSequence : true
    @Common.Label : 'Requisn. item'
    @Common.Heading : 'Item'
    @Common.QuickInfo : 'Item number of purchase requisition'
    key PurchaseRequisitionItem : String(5) not null;
    @Core.Computed : true
    @Common.IsUpperCase : true
    @Common.Label : 'Address'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=ADRNR'
    AddressID : String(10) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Plant'
    @Common.Heading : 'Plnt'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=EWERK'
    Plant : String(4) not null;
    @Core.Computed : true
    @Common.IsUpperCase : true
    @Common.Label : 'Address Type'
    @Common.Heading : 'Delivery Address Type'
    @Common.QuickInfo : 'Purchase Requisition Address Type'
    PurchasingDeliveryAddressType : String(1) not null;
    @Core.Computed : true
    @Common.IsUpperCase : true
    @Common.Label : 'Address'
    @Common.QuickInfo : 'Manual address number in purchasing document item'
    ManualDeliveryAddressID : String(10) not null;
    @Core.Computed : true
    @Common.IsUpperCase : true
    @Common.Label : 'Address'
    @Common.QuickInfo : 'Number of delivery address'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=ADRN2'
    ItemDeliveryAddressID : String(10) not null;
    @Common.Label : 'c/o'
    @Common.Heading : 'c/o name'
    @Common.QuickInfo : 'c/o name'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=AD_NAME_CO'
    CareOfName : String(40) not null;
    @Common.Label : 'Street 5'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=AD_LCTN'
    AdditionalStreetSuffixName : String(40) not null;
    @Common.Label : 'Language Key'
    @Common.Heading : 'Language'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=SPRAS'
    CorrespondenceLanguage : String(2) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Comm. Method'
    @Common.QuickInfo : 'Communication Method (Key) (Business Address Services)'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=AD_COMM'
    PrfrdCommMediumType : String(3) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'PO Box'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=AD_POBX'
    POBox : String(10) not null;
    @Common.Label : 'PO Box w/o No.'
    @Common.Heading : 'PO'
    @Common.QuickInfo : 'Flag: PO Box Without Number'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=AD_POBXNUM'
    POBoxIsWithoutNumber : Boolean not null;
    @Common.IsUpperCase : true
    @Common.Label : 'PO Box Postal Code'
    @Common.Heading : 'Postl Code'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=AD_PSTCD2'
    POBoxPostalCode : String(10) not null;
    @Common.Label : 'PO Box Lobby'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=AD_PO_BOX_LBY'
    POBoxLobbyName : String(40) not null;
    @Common.Label : 'PO Box City'
    @Common.QuickInfo : 'PO Box city'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=AD_POBXLOC'
    POBoxDeviatingCityName : String(40) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'PO Box Region'
    @Common.Heading : 'PO Region'
    @Common.QuickInfo : 'Region for PO Box (Country/Region, State, Province, ...)'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=AD_POBXREG'
    POBoxDeviatingRegion : String(3) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'PO Box Ctry/Region'
    @Common.Heading : 'PO C/R'
    @Common.QuickInfo : 'PO Box of Country/Region'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=AD_POBXCTY'
    POBoxDeviatingCountry : String(3) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Delvry Serv Type'
    @Common.QuickInfo : 'Type of Delivery Service'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=AD_DELIVERY_SERVICE_TYPE'
    DeliveryServiceTypeCode : String(4) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Delivery Service No.'
    @Common.Heading : 'Delivery Service Number'
    @Common.QuickInfo : 'Number of Delivery Service'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=AD_DELIVERY_SERVICE_NUMBER'
    DeliveryServiceNumber : String(10) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Time Zone'
    @Common.Heading : 'Zone'
    @Common.QuickInfo : 'Address Time Zone'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=AD_TZONE'
    AddressTimeZone : String(6) not null;
    @Core.Computed : true
    @Common.Label : 'Full Name'
    @Common.QuickInfo : 'Full name of a party (Bus. Partner, Org. Unit, Doc. address)'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=ADFULLNAME'
    FullName : String(80) not null;
    @Common.Label : 'City'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=AD_CITY1'
    CityName : String(40) not null;
    @Common.Label : 'District'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=AD_CITY2'
    District : String(40) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'City Code'
    @Common.QuickInfo : 'City code for city/street file'
    CityCode : String(12) not null;
    @Common.Label : 'Different City'
    @Common.Heading : 'City (Diff. from Postal City)'
    @Common.QuickInfo : 'City (different from postal city)'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=AD_CITY3'
    HomeCityName : String(40) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Postal Code'
    @Common.Heading : 'Post. Code'
    @Common.QuickInfo : 'City Postal Code'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=AD_PSTCD1'
    PostalCode : String(10) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Company Postal Code'
    @Common.Heading : 'Postl Code'
    @Common.QuickInfo : 'Company Postal Code (for Large Customers)'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=AD_PSTCD3'
    CompanyPostalCode : String(10) not null;
    @Common.Label : 'Street'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=AD_STREET'
    StreetName : String(60) not null;
    @Common.Label : 'Street 2'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=AD_STRSPP1'
    StreetPrefixName : String(40) not null;
    @Common.Label : 'Street 3'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=AD_STRSPP2'
    AdditionalStreetPrefixName : String(40) not null;
    @Common.Label : 'Street 4'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=AD_STRSPP3'
    StreetSuffixName : String(40) not null;
    @Common.Label : 'House Number'
    @Common.Heading : 'House No.'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=AD_HSNM1'
    HouseNumber : String(10) not null;
    @Common.Label : 'Supplement'
    @Common.QuickInfo : 'House number supplement'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=AD_HSNM2'
    HouseNumberSupplementText : String(10) not null;
    @Common.Label : 'Building Code'
    @Common.Heading : 'Building'
    @Common.QuickInfo : 'Building (Number or Code)'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=AD_BLDNG'
    Building : String(20) not null;
    @Common.Label : 'Floor'
    @Common.QuickInfo : 'Floor in Building'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=AD_FLOOR'
    Floor : String(10) not null;
    @Common.Label : 'Room Number'
    @Common.Heading : 'Room No.'
    @Common.QuickInfo : 'Room or Apartment Number'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=AD_ROOMNUM'
    RoomNumber : String(10) not null;
    @Common.SAPObjectNodeTypeReference : 'Country'
    @Common.IsUpperCase : true
    @Common.Label : 'Country/Region Key'
    @Common.Heading : 'C/R'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=LAND1'
    Country : String(3) not null;
    @Common.SAPObjectNodeTypeReference : 'Region'
    @Common.IsUpperCase : true
    @Common.Label : 'Region'
    @Common.Heading : 'Rg'
    @Common.QuickInfo : 'Region (State, Province, County)'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=REGIO'
    Region : String(3) not null;
    @Common.Label : 'County'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=AD_COUNTY'
    County : String(40) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Title Key'
    @Common.Heading : 'Key'
    @Common.QuickInfo : 'Form-of-Address Key'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=AD_TITLE'
    FormOfAddress : String(4) not null;
    @Common.Label : 'Name'
    @Common.QuickInfo : 'Name 1'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=AD_NAME1'
    BusinessPartnerName1 : String(40) not null;
    @Common.Label : 'Name 2'
    BusinessPartnerName2 : String(40) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Telephone'
    @Common.QuickInfo : 'Telephone No.: Dialing Code and Number'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=AD_TLNMBR'
    PhoneNumber : String(30) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Fax'
    @Common.QuickInfo : 'Fax Number: Dialing Code and Number'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=AD_FXNMBR'
    FaxNumber : String(30) not null;
    @Common.Label : 'Email Address'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=AD_SMTPADR'
    EmailAddress : String(241) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Search Term 1'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=AD_SORT1'
    SearchTerm1 : String(20) not null;
    @Common.Label : 'Name 3'
    BusinessPartnerName3 : String(40) not null;
    @Common.Label : 'Name 4'
    BusinessPartnerName4 : String(40) not null;
    @Common.SAPObjectNodeTypeReference : 'TaxJurisdiction'
    @Common.IsUpperCase : true
    @Common.Label : 'Tax Jurisdiction'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=AD_TXJCD'
    TaxJurisdiction : String(15) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Transportation Zone'
    @Common.Heading : 'TranspZone'
    @Common.QuickInfo : 'Transportation zone to or from which the goods are delivered'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=LZONE'
    TransportZone : String(10) not null;
    SAP__Messages : many SAP__Message not null;
    _PurchaseRequisitionItem : Association to one PurchaseReqnItem on _PurchaseRequisitionItem.PurchaseRequisitionItem = PurchaseRequisitionItem;
    _PurReqn : Association to one PurchaseReqn on _PurReqn.PurchaseRequisition = PurchaseRequisition;
  };

  @cds.external : true
  @cds.persistence.skip : true
  @Common.Label : 'Item'
  @Common.SemanticKey : [ 'PurchaseRequisitionItem', 'PurchaseRequisition' ]
  @Common.Messages : SAP__Messages
  @Capabilities.NavigationRestrictions.RestrictedProperties : [
    {
      NavigationProperty: _PurchaseReqnDelivAddress,
      InsertRestrictions: { Insertable: true }
    },
    {
      NavigationProperty: _PurchaseReqnItemText,
      FilterRestrictions: { Filterable: false }
    },
    {
      NavigationProperty: _PurReqn,
      InsertRestrictions: { Insertable: false },
      DeepUpdateSupport: { Supported: false }
    }
  ]
  @Capabilities.SearchRestrictions.Searchable : false
  @Capabilities.UpdateRestrictions.DeltaUpdateSupported : true
  @Capabilities.UpdateRestrictions.NonUpdatableProperties : [ 'ExternalApprovalStatus' ]
  @Capabilities.UpdateRestrictions.NonUpdatableNavigationProperties : [
    '_PurchaseReqnAcctAssgmt',
    '_PurchaseReqnDelivAddress',
    '_PurchaseReqnItemText',
    '_PurReqn'
  ]
  @Capabilities.UpdateRestrictions.QueryOptions.SelectSupported : true
  @Capabilities.DeepUpdateSupport.ContentIDSupported : true
  @Capabilities.DeleteRestrictions.Deletable : false
  @Core.OptimisticConcurrency : [ 'LastChangeDateTime' ]
  @Capabilities.FilterRestrictions.FilterExpressionRestrictions : [
    { Property: RequestedQuantity, AllowedExpressions: 'MultiValue' },
    { Property: BaseUnit, AllowedExpressions: 'MultiValue' },
    { Property: BaseUnitISOCode, AllowedExpressions: 'MultiValue' },
    { Property: PurchaseRequisitionPrice, AllowedExpressions: 'MultiValue' },
    { Property: PurReqnPriceQuantity, AllowedExpressions: 'MultiValue' },
    { Property: OrderedQuantity, AllowedExpressions: 'MultiValue' },
    { Property: ItemNetAmount, AllowedExpressions: 'MultiValue' },
    {
      Property: ExpectedOverallLimitAmount,
      AllowedExpressions: 'MultiValue'
    },
    { Property: OverallLimitAmount, AllowedExpressions: 'MultiValue' }
  ]
  entity PurchaseReqnItem {
    @Core.ComputedDefaultValue : true
    @Common.IsUpperCase : true
    @Common.Label : 'Purchase Requisition'
    @Common.Heading : 'Purch.Reqn'
    @Common.QuickInfo : 'Purchase Requisition Number'
    key PurchaseRequisition : String(10) not null;
    @Core.ComputedDefaultValue : true
    @Common.IsDigitSequence : true
    @Common.Label : 'Requisn. item'
    @Common.Heading : 'Item'
    @Common.QuickInfo : 'Item number of purchase requisition'
    key PurchaseRequisitionItem : String(5) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Purchase Order'
    @Common.Heading : 'PO'
    @Common.QuickInfo : 'Purchase Order Number'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=BSTNR'
    PurchasingDocument : String(10) not null;
    @Common.IsDigitSequence : true
    @Common.Label : 'Purchase Order Item'
    @Common.Heading : 'Item'
    @Common.QuickInfo : 'Purchase order item number'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=BSTPO'
    PurchasingDocumentItem : String(5) not null;
    @Core.Computed : true
    @Common.IsUpperCase : true
    @Common.Label : 'Proc.state'
    @Common.Heading : 'Purchase requisition processing state'
    @Common.QuickInfo : 'Requisition Processing State'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=BANPR'
    PurReqnReleaseStatus : String(2) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Control indicator'
    @Common.Heading : 'Ctl'
    @Common.QuickInfo : 'Control indicator for purchasing document type'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=BSAKZ'
    PurchasingDocumentSubtype : String(1) not null;
    @Common.SAPObjectNodeTypeReference : 'PurchasingDocumentItemCategory'
    @Common.IsUpperCase : true
    @Common.Label : 'Item Category'
    @Common.Heading : 'I'
    @Common.QuickInfo : 'Item category in purchasing document'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=PSTYP'
    PurchasingDocumentItemCategory : String(1) not null;
    @Common.Label : 'Short Text'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=TXZ01'
    PurchaseRequisitionItemText : String(40) not null;
    @Common.SAPObjectNodeTypeReference : 'AccountAssignmentCategory'
    @Common.IsUpperCase : true
    @Common.Label : 'Acct Assignment Cat.'
    @Common.Heading : 'A'
    @Common.QuickInfo : 'Account Assignment Category'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=KNTTP'
    AccountAssignmentCategory : String(1) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Material'
    @Common.QuickInfo : 'Material Number'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=MATNR'
    Material : String(40) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Material Group'
    @Common.Heading : 'Matl Group'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=MATKL'
    MaterialGroup : String(9) not null;
    @Measures.Unit : BaseUnit
    @Measures.UNECEUnit : BaseUnitISOCode
    @Common.Label : 'Quantity requested'
    @Common.Heading : 'Qty requested'
    @Common.QuickInfo : 'Purchase requisition quantity'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=BAMNG'
    RequestedQuantity : Decimal(13, 3) not null;
    @Common.IsUnit : true
    @Common.Label : 'Unit of Measure'
    @Common.Heading : 'Un'
    @Common.QuickInfo : 'Purchase requisition unit of measure'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=BAMEI'
    BaseUnit : String(3) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'ISO Code'
    @Common.Heading : 'ISO'
    @Common.QuickInfo : 'ISO Code for Unit of Measurement'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=ISOCD_UNIT'
    BaseUnitISOCode : String(3) not null;
    @Measures.ISOCurrency : PurReqnItemCurrency
    @Common.Label : 'Valuation Price'
    @Common.Heading : 'Valn Price'
    @Common.QuickInfo : 'Price in Purchase Requisition'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=BAPRE'
    PurchaseRequisitionPrice : Decimal(precision: 11) not null;
    @Measures.Unit : BaseUnit
    @Measures.UNECEUnit : BaseUnitISOCode
    @Common.Label : 'Price Unit'
    @Common.Heading : 'Per'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=EPEIN'
    PurReqnPriceQuantity : Decimal(precision: 5) not null;
    @Common.Label : 'GR processing time'
    @Common.Heading : 'GRT'
    @Common.QuickInfo : 'Goods receipt processing time in days'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=WEBAZ'
    MaterialGoodsReceiptDuration : Decimal(precision: 3) not null;
    @Common.SAPObjectNodeTypeReference : 'PurchasingOrganization'
    PurchasingOrganization : String(4) not null;
    @Common.SAPObjectNodeTypeReference : 'PurchasingGroup'
    @Common.IsUpperCase : true
    @Common.Label : 'Purchasing Group'
    @Common.Heading : 'PGr'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=EKGRP'
    PurchasingGroup : String(3) not null;
    Plant : String(4) not null;
    CompanyCode : String(4) not null;
    @Common.Label : 'Assigned'
    @Common.Heading : 'A'
    @Common.QuickInfo : 'Assigned Source of Supply'
    SourceOfSupplyIsAssigned : Boolean not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Supplying Plant'
    @Common.Heading : 'SPlt'
    @Common.QuickInfo : 'Supplying (issuing) plant in case of stock transport order'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=RESWK'
    SupplyingPlant : String(4) not null;
    @Measures.Unit : BaseUnit
    @Measures.UNECEUnit : BaseUnitISOCode
    @Common.Label : 'Quantity ordered'
    @Common.Heading : 'Ordered'
    @Common.QuickInfo : 'Quantity ordered against this purchase requisition'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=BSMNG'
    OrderedQuantity : Decimal(13, 3) not null;
    @Common.Label : 'Delivery Date'
    @Common.Heading : 'Deliv. Date'
    @Common.QuickInfo : 'Item Delivery Date'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=EINDT'
    DeliveryDate : Date;
    @Common.Label : 'Release Date'
    @Common.Heading : 'Release Dt'
    @Common.QuickInfo : 'Purchase Requisition Release Date'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=FRGDT'
    PurchaseRequisitionReleaseDate : Date;
    @Common.SAPObjectNodeTypeReference : 'EntProjectProcessingStatus'
    @Common.IsUpperCase : true
    @Common.Label : 'Processing status'
    @Common.Heading : 'S'
    @Common.QuickInfo : 'Processing status of purchase requisition'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=BANST'
    ProcessingStatus : String(1) not null;
    @Core.Immutable : true
    @Common.IsUpperCase : true
    @Common.Label : 'Ext Prcsng. Status'
    @Common.Heading : 'External Processing Status'
    @Common.QuickInfo : 'External Processing Status'
    ExternalApprovalStatus : String(1) not null;
    PurchasingInfoRecord : String(10) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Supplier'
    @Common.QuickInfo : 'Account Number of Supplier'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=LIFNR'
    Supplier : String(10) not null;
    @Common.Label : 'Deletion Indicator'
    @Common.Heading : 'D'
    @Common.QuickInfo : 'Deletion Indicator in Purchasing Document'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=ELOEK'
    IsDeleted : Boolean not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Fixed Vendor'
    @Common.Heading : 'Fix.Vend.'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=FLIEF'
    FixedSupplier : String(10) not null;
    @Common.Label : 'Requisitioner'
    @Common.Heading : 'Requisnr.'
    @Common.QuickInfo : 'Name of requisitioner/requester'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=AFNAM'
    RequisitionerName : String(12) not null;
    @Core.Computed : true
    @Common.IsUpperCase : true
    @Common.Label : 'Created By'
    @Common.QuickInfo : 'Name of Person Responsible for Creating the Object'
    CreatedByUser : String(12) not null;
    @Common.Label : 'Requisition Date'
    @Common.Heading : 'Req.Date'
    @Common.QuickInfo : 'Requisition (Request) Date'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=BADAT'
    PurReqCreationDate : Date;
    @Common.IsCurrency : true
    @Common.IsUpperCase : true
    @Common.Label : 'Currency'
    @Common.Heading : 'Crcy'
    @Common.QuickInfo : 'Currency Key'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=WAERS'
    PurReqnItemCurrency : String(3) not null;
    @Common.Label : 'Planned Deliv. Time'
    @Common.Heading : 'PDT'
    @Common.QuickInfo : 'Planned Delivery Time in Days'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=PLIFZ'
    MaterialPlannedDeliveryDurn : Decimal(precision: 3) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Deliv. date category'
    @Common.Heading : 'C'
    @Common.QuickInfo : 'Category of delivery date'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=LPEIN'
    DelivDateCategory : String(1) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Distribut. Indicator'
    @Common.Heading : 'D'
    @Common.QuickInfo : 'Distribution Indicator for Multiple Account Assignment'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=VRTKZ'
    MultipleAcctAssgmtDistribution : String(1) not null;
    @Common.SAPObjectNodeTypeReference : 'StorageLocation'
    @Common.IsUpperCase : true
    @Common.Label : 'Storage Location'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=LGORT_D'
    StorageLocation : String(4) not null;
    @Common.Label : 'Requestor'
    PurReqnSSPRequestor : String(60) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Author'
    @Common.QuickInfo : 'Author of Requisition'
    PurReqnSSPAuthor : String(12) not null;
    PurchaseContract : String(10) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Purch. Doc. Category'
    @Common.Heading : 'Cat'
    @Common.QuickInfo : 'Purchasing Document Category'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=BSTYP'
    PurReqnSourceOfSupplyType : String(1) not null;
    @Common.IsDigitSequence : true
    PurchaseContractItem : String(5) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Consumption'
    @Common.Heading : 'Cns'
    @Common.QuickInfo : 'Consumption posting'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=KZVBR'
    ConsumptionPosting : String(1) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Creation indicator'
    @Common.Heading : 'C'
    @Common.QuickInfo : 'Creation indicator (purchase requisition/schedule lines)'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=ESTKZ'
    PurReqnOrigin : String(1) not null;
    @Common.Label : 'Web Service ID'
    @Common.Heading : 'Technical Key of a Web Service'
    @Common.QuickInfo : 'Technical Key of a Web Service (for Example - a Catalog)'
    PurReqnSSPCatalog : String(20) not null;
    @Common.Label : 'Catalog Item'
    @Common.QuickInfo : 'Catalog Item Id'
    PurReqnSSPCatalogItem : String(40) not null;
    @Common.Label : 'Catalog Item Key'
    PurReqnSSPCrossCatalogItem : Integer not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Blocking Indicator'
    @Common.Heading : 'Block'
    @Common.QuickInfo : 'Purchase Requisition Blocked'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=BLCKD'
    PurReqnItemBlockingStatus : String(1) not null;
    @Common.Label : 'Blocking Text'
    @Common.QuickInfo : 'Reason for Item Block'
    PurReqnItemBlockingReasonText : String(60) not null;
    @Common.Label : 'Language Key'
    @Common.Heading : 'Language'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=SPRAS'
    Language : String(2) not null;
    @Common.Label : 'Closed'
    @Common.Heading : 'Cl.'
    @Common.QuickInfo : 'Purchase requisition closed'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=EBAKZ'
    IsClosed : Boolean not null;
    @Core.Computed : true
    @Common.Label : 'Subject to Release'
    @Common.Heading : 'R'
    @Common.QuickInfo : 'Release Not Yet Completely Effected'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=FRGRL'
    ReleaseIsNotCompleted : Boolean not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Service Performer'
    @Common.Heading : 'SrvPrfm'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=SERVICEPERFORMER'
    ServicePerformer : String(10) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Product Type Group'
    @Common.Heading : 'Product Type Grp'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=PRODUCT_TYPE'
    ProductTypeCode : String(2) not null;
    @Common.Label : 'Start Date'
    @Common.QuickInfo : 'Start Date for Period of Performance'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=MMPUR_SERVPROC_PERIOD_START'
    PerformancePeriodStartDate : Date;
    @Common.Label : 'End Date'
    @Common.QuickInfo : 'End Date for Period of Performance'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=MMPUR_SERVPROC_PERIOD_END'
    PerformancePeriodEndDate : Date;
    @Common.IsUpperCase : true
    @Common.Label : 'Purchase order price'
    @Common.Heading : 'P'
    @Common.QuickInfo : 'Use Requisition Price in Purchase Order'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=BPUEB'
    PurchaseOrderPriceType : String(1) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Supplier Mat. No.'
    @Common.Heading : 'Supplier Material Number'
    @Common.QuickInfo : 'Material Number Used by Supplier'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=IDNLF'
    SupplierMaterialNumber : String(35) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Batch'
    @Common.QuickInfo : 'Batch Number'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=CHARG_D'
    Batch : String(10) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Revision Level'
    MaterialRevisionLevel : String(2) not null;
    @Common.Label : 'Min. Rem. Shelf Life'
    @Common.Heading : 'RShLi'
    @Common.QuickInfo : 'Minimum Remaining Shelf Life'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=MHDRZ'
    MinRemainingShelfLife : Decimal(precision: 4) not null;
    @Measures.ISOCurrency : PurReqnItemCurrency
    ItemNetAmount : Decimal(precision: 15) not null;
    @Common.SAPObjectNodeTypeReference : 'SalesTaxCode'
    @Common.IsUpperCase : true
    @Common.Label : 'Tax Code'
    @Common.Heading : 'Tx'
    @Common.QuickInfo : 'Tax on Sales/Purchases Code'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=MWSKZ'
    TaxCode : String(2) not null;
    @Common.Label : 'Goods Receipt'
    @Common.Heading : 'GR'
    @Common.QuickInfo : 'Goods Receipt Indicator'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=WEPOS'
    GoodsReceiptIsExpected : Boolean not null;
    @Common.Label : 'Invoice Receipt'
    @Common.Heading : 'IR'
    @Common.QuickInfo : 'Invoice Receipt Indicator'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=REPOS'
    InvoiceIsExpected : Boolean not null;
    @Common.Label : 'GR Non-Valuated'
    @Common.Heading : 'N'
    @Common.QuickInfo : 'Goods Receipt, Non-Valuated'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=WEUNB'
    GoodsReceiptIsNonValuated : Boolean not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Req. Tracking Number'
    @Common.Heading : 'TrackingNo'
    @Common.QuickInfo : 'Requirement Tracking Number'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=BEDNR'
    RequirementTracking : String(10) not null;
    @Common.SAPObjectNodeTypeReference : 'MRPController'
    @Common.IsUpperCase : true
    @Common.Label : 'MRP Controller'
    @Common.Heading : 'MRPCn'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=DISPO'
    MRPController : String(3) not null;
    @Common.Label : '"Fixed" indicator'
    @Common.Heading : 'Fx'
    @Common.QuickInfo : 'Purchase requisition is fixed'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=BAFIX'
    PurchaseRequisitionIsFixed : Boolean not null;
    @odata.Precision : 7
    @odata.Type : 'Edm.DateTimeOffset'
    @Core.Computed : true
    @Common.Label : 'Time Stamp'
    @Common.QuickInfo : 'UTC Time Stamp in Long Form (YYYYMMDDhhmmssmmmuuun)'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=TIMESTAMPL'
    LastChangeDateTime : Timestamp;
    @Core.Computed : true
    @Common.IsDigitSequence : true
    @Common.Label : 'Reservation'
    @Common.Heading : 'Reserv.no.'
    @Common.QuickInfo : 'Number of reservation/dependent requirements'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=RSNUM'
    Reservation : String(10) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Address'
    @Common.QuickInfo : 'Number of delivery address'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=ADRN2'
    ItemDeliveryAddressID : String(10) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Customer'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=EKUNNR'
    PurReqnReceivingCustomer : String(10) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Supplier'
    @Common.QuickInfo : 'Supplier to be Supplied/Who is to Receive Delivery'
    Subcontractor : String(10) not null;
    @Measures.ISOCurrency : PurReqnItemCurrency
    @Common.Label : 'Expected Value'
    @Common.QuickInfo : 'Expected Value of Overall Limit'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=COMMITMENT'
    ExpectedOverallLimitAmount : Decimal(precision: 13) not null;
    @Measures.ISOCurrency : PurReqnItemCurrency
    @Common.Label : 'Overall Limit'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=SUMLIMIT'
    OverallLimitAmount : Decimal(precision: 13) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Contract for Limit'
    @Common.QuickInfo : 'Purchase Contract for Enhanced Limit'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=CTR_FOR_LIMIT'
    PurContractForOverallLimit : String(10) not null;
    @Common.IsDigitSequence : true
    @Common.Label : 'PurCon Itm for Limit'
    @Common.Heading : 'Purchase Contract Reference Item for Enhanced Limit Itm'
    @Common.QuickInfo : 'Purchase Contract Reference Item for Enhanced Limit Item'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=CTR_ITEM_FOR_LIMIT'
    PurContractItemForOverallLimit : String(5) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'External Document'
    @Common.Heading : 'Document Number of External Document'
    @Common.QuickInfo : 'Document Number of External Document'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=ME_PUR_EXT_DOC_ID'
    PurReqnExternalReference : String(35) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'External Item'
    @Common.Heading : 'Item Number of External Document'
    @Common.QuickInfo : 'Item Number of External Document'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=ME_PUR_EXT_DOC_ITEM_ID'
    PurReqnItemExternalReference : String(10) not null;
    @Common.Label : 'External System ID'
    PurReqnExternalSystemId : String(60) not null;
    @Common.Label : 'Connected System ID'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=MMPUR_D_SOURCE_SYS'
    ProcurementHubSourceSystem : String(10) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'BP ID of Author'
    SSPAuthorExternalBPIdnNumber : String(60) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Requestor UserID'
    @Common.Heading : 'Requestor User ID'
    @Common.QuickInfo : 'Requestor User ID'
    SSPReqrUserId : String(12) not null;
    SAP__Messages : many SAP__Message not null;
    @Common.Composition : true
    _PurchaseReqnAcctAssgmt : Composition of many PurchaseReqnAcctAssgmt on _PurchaseReqnAcctAssgmt._PurchaseRequisitionItem = $self;
    @Common.Composition : true
    _PurchaseReqnDelivAddress : Composition of one PurchaseReqnDelivAddress on _PurchaseReqnDelivAddress._PurchaseRequisitionItem = $self;
    @Common.Composition : true
    _PurchaseReqnItemText : Composition of many PurchaseReqnItemText on _PurchaseReqnItemText._PurchaseRequisitionItem = $self;
    _PurReqn : Association to one PurchaseReqn on _PurReqn.PurchaseRequisition = PurchaseRequisition;
  } actions {
    action DiscardPurReqItemFromPurg();
    action EnablePurReqItemForPurchasing();
  };

  @cds.external : true
  @cds.persistence.skip : true
  @Common.Label : 'Item Notes'
  @Common.SemanticKey : [
    'Language',
    'TextObjectType',
    'TextObjectKey',
    'TextObjectCategory',
    'PurchaseRequisitionItem',
    'PurchaseRequisition'
  ]
  @Common.Messages : SAP__Messages
  @Capabilities.NavigationRestrictions.RestrictedProperties : [
    {
      NavigationProperty: _PurchaseRequisitionItem,
      InsertRestrictions: { Insertable: false },
      DeepUpdateSupport: { Supported: false },
      SortRestrictions: { Sortable: false },
      FilterRestrictions: { Filterable: false }
    },
    {
      NavigationProperty: _PurReqn,
      InsertRestrictions: { Insertable: false },
      DeepUpdateSupport: { Supported: false },
      SortRestrictions: { Sortable: false },
      FilterRestrictions: { Filterable: false }
    }
  ]
  @Capabilities.SearchRestrictions.Searchable : false
  @Capabilities.FilterRestrictions.Filterable : true
  @Capabilities.FilterRestrictions.FilterExpressionRestrictions : [ { Property: PlainLongText, AllowedExpressions: 'SearchExpression' } ]
  @Capabilities.SortRestrictions.NonSortableProperties : [ 'PlainLongText' ]
  @Capabilities.UpdateRestrictions.DeltaUpdateSupported : true
  @Capabilities.UpdateRestrictions.NonUpdatableNavigationProperties : [ '_PurchaseRequisitionItem', '_PurReqn' ]
  @Capabilities.UpdateRestrictions.QueryOptions.SelectSupported : true
  @Capabilities.DeepUpdateSupport.ContentIDSupported : true
  @Core.OptimisticConcurrency : true
  entity PurchaseReqnItemText {
    @Core.ComputedDefaultValue : true
    @Common.IsUpperCase : true
    @Common.Label : 'Purchase Requisition'
    @Common.Heading : 'Purch.Req.'
    @Common.QuickInfo : 'Purchase Requisition Number'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=BANFN'
    key PurchaseRequisition : String(10) not null;
    @Core.ComputedDefaultValue : true
    @Common.IsDigitSequence : true
    @Common.Label : 'Item of requisition'
    @Common.Heading : 'Item'
    @Common.QuickInfo : 'Item Number of Purchase Requisition'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=BNFPO'
    key PurchaseRequisitionItem : String(5) not null;
    @Core.ComputedDefaultValue : true
    @Common.IsUpperCase : true
    @Common.Label : 'Text object'
    @Common.Heading : 'Object'
    @Common.QuickInfo : 'Texts: application object'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=TDOBJECT'
    key TextObjectCategory : String(10) not null;
    @Core.ComputedDefaultValue : true
    @Common.IsUpperCase : true
    @Common.Label : 'Text Name'
    @Common.Heading : 'Text'
    @Common.QuickInfo : 'Name'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=TDOBNAME'
    key TextObjectKey : String(70) not null;
    @Core.ComputedDefaultValue : true
    @Common.IsUpperCase : true
    @Common.Label : 'Text ID'
    @Common.Heading : 'ID'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=TDID'
    key TextObjectType : String(4) not null;
    @Core.ComputedDefaultValue : true
    @Common.Label : 'Language Key'
    @Common.Heading : 'Language'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=SPRAS'
    key Language : String(2) not null;
    @Common.Label : 'Long Text'
    PlainLongText : String not null;
    @Core.Computed : true
    @Common.IsUpperCase : true
    @Common.Label : 'Fixing'
    @Common.Heading : 'Fix'
    @Common.QuickInfo : '"Fixed" Indicator for Texts'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=FIXIE'
    FixedIndicator : String(1) not null;
    SAP__Messages : many SAP__Message not null;
    _PurchaseRequisitionItem : Association to one PurchaseReqnItem on _PurchaseRequisitionItem.PurchaseRequisitionItem = PurchaseRequisitionItem;
    _PurReqn : Association to one PurchaseReqn on _PurReqn.PurchaseRequisition = PurchaseRequisition;
  };
};

