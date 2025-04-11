package projects.tanks.client.garage.models.garage {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.CollectionCodecInfo;
  import alternativa.protocol.info.EnumCodecInfo;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.registry.ModelRegistry;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.commons.types.ItemViewCategoryEnum;

  public class GarageModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:GarageModelServer;

    private var client:IGarageModelBase = IGarageModelBase(this);
    private var modelId:Long = Long.getLong(1718746868,-1910730614);
    private var _initDepotId:Long = Long.getLong(930502521,-307520123);
    private var _initDepot_itemsOnDepotCodec:ICodec;
    private var _initMarketId:Long = Long.getLong(1219192892,689165557);
    private var _initMarket_itemsOnMarketCodec:ICodec;
    private var _initMountedId:Long = Long.getLong(859726007,514386313);
    private var _initMounted_mountedItemsCodec:ICodec;
    private var _reloadGarageId:Long = Long.getLong(933245382,1068161023);
    private var _reloadGarage_messageCodec:ICodec;
    private var _reloadGarage_totalCrystalsCodec:ICodec;
    private var _removeDepotItemId:Long = Long.getLong(1177280707,-1253059324);
    private var _removeDepotItem_itemCodec:ICodec;
    private var _selectId:Long = Long.getLong(1672979457,540290587);
    private var _select_itemToSelectCodec:ICodec;
    private var _selectFirstItemInDepotId:Long = Long.getLong(450776038,1263898393);
    private var _showCategoryId:Long = Long.getLong(939753622,116528378);
    private var _showCategory_viewCategoryCodec:ICodec;
    private var _unmountDroneId:Long = Long.getLong(952716796,14349239);
    private var _updateDepotItemId:Long = Long.getLong(2006024142,-2135822943);
    private var _updateDepotItem_itemCodec:ICodec;
    private var _updateDepotItem_countCodec:ICodec;
    private var _updateMountedItemsId:Long = Long.getLong(1235090973,1845524944);
    private var _updateMountedItems_mountedItemsCodec:ICodec;
    private var _updateTemporaryItemId:Long = Long.getLong(1589955723,815412220);
    private var _updateTemporaryItem_itemCodec:ICodec;
    private var _updateTemporaryItem_remainingTimeSecondsCodec:ICodec;

    public function GarageModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new GarageModelServer(IModel(this));
      var local1:ModelRegistry = ModelRegistry(OSGi.getInstance().getService(ModelRegistry));
      local1.registerModelConstructorCodec(this.modelId,this._protocol.getCodec(new TypeCodecInfo(GarageModelCC,false)));
      this._initDepot_itemsOnDepotCodec = this._protocol.getCodec(new CollectionCodecInfo(new TypeCodecInfo(IGameObject,false),false,1));
      this._initMarket_itemsOnMarketCodec = this._protocol.getCodec(new CollectionCodecInfo(new TypeCodecInfo(IGameObject,false),false,1));
      this._initMounted_mountedItemsCodec = this._protocol.getCodec(new CollectionCodecInfo(new TypeCodecInfo(IGameObject,false),false,1));
      this._reloadGarage_messageCodec = this._protocol.getCodec(new TypeCodecInfo(String,false));
      this._reloadGarage_totalCrystalsCodec = this._protocol.getCodec(new TypeCodecInfo(int,false));
      this._removeDepotItem_itemCodec = this._protocol.getCodec(new TypeCodecInfo(IGameObject,false));
      this._select_itemToSelectCodec = this._protocol.getCodec(new TypeCodecInfo(IGameObject,false));
      this._showCategory_viewCategoryCodec = this._protocol.getCodec(new EnumCodecInfo(ItemViewCategoryEnum,false));
      this._updateDepotItem_itemCodec = this._protocol.getCodec(new TypeCodecInfo(IGameObject,false));
      this._updateDepotItem_countCodec = this._protocol.getCodec(new TypeCodecInfo(int,false));
      this._updateMountedItems_mountedItemsCodec = this._protocol.getCodec(new CollectionCodecInfo(new TypeCodecInfo(IGameObject,false),false,1));
      this._updateTemporaryItem_itemCodec = this._protocol.getCodec(new TypeCodecInfo(IGameObject,false));
      this._updateTemporaryItem_remainingTimeSecondsCodec = this._protocol.getCodec(new TypeCodecInfo(int,false));
    }

    protected function getInitParam() : GarageModelCC {
      return GarageModelCC(initParams[Model.object]);
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._initDepotId:
          this.client.initDepot(this._initDepot_itemsOnDepotCodec.decode(param2) as Vector.<IGameObject>);
          break;
        case this._initMarketId:
          this.client.initMarket(this._initMarket_itemsOnMarketCodec.decode(param2) as Vector.<IGameObject>);
          break;
        case this._initMountedId:
          this.client.initMounted(this._initMounted_mountedItemsCodec.decode(param2) as Vector.<IGameObject>);
          break;
        case this._reloadGarageId:
          this.client.reloadGarage(String(this._reloadGarage_messageCodec.decode(param2)),int(this._reloadGarage_totalCrystalsCodec.decode(param2)));
          break;
        case this._removeDepotItemId:
          this.client.removeDepotItem(IGameObject(this._removeDepotItem_itemCodec.decode(param2)));
          break;
        case this._selectId:
          this.client.select(IGameObject(this._select_itemToSelectCodec.decode(param2)));
          break;
        case this._selectFirstItemInDepotId:
          this.client.selectFirstItemInDepot();
          break;
        case this._showCategoryId:
          this.client.showCategory(ItemViewCategoryEnum(this._showCategory_viewCategoryCodec.decode(param2)));
          break;
        case this._unmountDroneId:
          this.client.unmountDrone();
          break;
        case this._updateDepotItemId:
          this.client.updateDepotItem(IGameObject(this._updateDepotItem_itemCodec.decode(param2)),int(this._updateDepotItem_countCodec.decode(param2)));
          break;
        case this._updateMountedItemsId:
          this.client.updateMountedItems(this._updateMountedItems_mountedItemsCodec.decode(param2) as Vector.<IGameObject>);
          break;
        case this._updateTemporaryItemId:
          this.client.updateTemporaryItem(IGameObject(this._updateTemporaryItem_itemCodec.decode(param2)),int(this._updateTemporaryItem_remainingTimeSecondsCodec.decode(param2)));
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
