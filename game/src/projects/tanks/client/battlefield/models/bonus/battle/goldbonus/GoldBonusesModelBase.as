package projects.tanks.client.battlefield.models.bonus.battle.goldbonus {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.registry.ModelRegistry;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.battlefield.models.bonus.battle.bonusregions.BonusRegionData;

  public class GoldBonusesModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:GoldBonusesModelServer;

    private var client:IGoldBonusesModelBase = IGoldBonusesModelBase(this);
    private var modelId:Long = Long.getLong(777565245,-2042440396);
    private var _hideDropZoneId:Long = Long.getLong(60276456,-1563681214);
    private var _hideDropZone_bonusRegionDataCodec:ICodec;
    private var _notificationBonusId:Long = Long.getLong(1350703047,2026111859);
    private var _notificationBonus_battleObjectCodec:ICodec;
    private var _notificationBonus_bonusRegionDataCodec:ICodec;
    private var _notificationBonusContainsUidId:Long = Long.getLong(1837388137,-508116030);
    private var _notificationBonusContainsUid_battleObjectCodec:ICodec;
    private var _notificationBonusContainsUid_uidCodec:ICodec;
    private var _notificationBonusContainsUid_bonusRegionDataCodec:ICodec;

    public function GoldBonusesModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new GoldBonusesModelServer(IModel(this));
      var local1:ModelRegistry = ModelRegistry(OSGi.getInstance().getService(ModelRegistry));
      local1.registerModelConstructorCodec(this.modelId,this._protocol.getCodec(new TypeCodecInfo(GoldBonusCC,false)));
      this._hideDropZone_bonusRegionDataCodec = this._protocol.getCodec(new TypeCodecInfo(BonusRegionData,false));
      this._notificationBonus_battleObjectCodec = this._protocol.getCodec(new TypeCodecInfo(IGameObject,false));
      this._notificationBonus_bonusRegionDataCodec = this._protocol.getCodec(new TypeCodecInfo(BonusRegionData,false));
      this._notificationBonusContainsUid_battleObjectCodec = this._protocol.getCodec(new TypeCodecInfo(IGameObject,false));
      this._notificationBonusContainsUid_uidCodec = this._protocol.getCodec(new TypeCodecInfo(String,false));
      this._notificationBonusContainsUid_bonusRegionDataCodec = this._protocol.getCodec(new TypeCodecInfo(BonusRegionData,false));
    }

    protected function getInitParam() : GoldBonusCC {
      return GoldBonusCC(initParams[Model.object]);
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._hideDropZoneId:
          this.client.hideDropZone(BonusRegionData(this._hideDropZone_bonusRegionDataCodec.decode(param2)));
          break;
        case this._notificationBonusId:
          this.client.notificationBonus(IGameObject(this._notificationBonus_battleObjectCodec.decode(param2)),BonusRegionData(this._notificationBonus_bonusRegionDataCodec.decode(param2)));
          break;
        case this._notificationBonusContainsUidId:
          this.client.notificationBonusContainsUid(IGameObject(this._notificationBonusContainsUid_battleObjectCodec.decode(param2)),String(this._notificationBonusContainsUid_uidCodec.decode(param2)),BonusRegionData(this._notificationBonusContainsUid_bonusRegionDataCodec.decode(param2)));
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
