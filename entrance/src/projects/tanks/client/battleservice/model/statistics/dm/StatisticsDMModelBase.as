package projects.tanks.client.battleservice.model.statistics.dm {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.CollectionCodecInfo;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.registry.ModelRegistry;
  import projects.tanks.client.battleservice.model.statistics.UserInfo;
  import projects.tanks.client.battleservice.model.statistics.UserStat;

  public class StatisticsDMModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:StatisticsDMModelServer;

    private var client:IStatisticsDMModelBase = IStatisticsDMModelBase(this);
    private var modelId:Long = Long.getLong(575618390,177970779);
    private var _changeUserStatId:Long = Long.getLong(965223943,535616065);
    private var _changeUserStat_userStatCodec:ICodec;
    private var _refreshUsersStatId:Long = Long.getLong(2010192701,-2134483217);
    private var _refreshUsersStat_usersStatCodec:ICodec;
    private var _userConnectId:Long = Long.getLong(825794462,-1556026223);
    private var _userConnect_userIdCodec:ICodec;
    private var _userConnect_usersInfoCodec:ICodec;
    private var _userDisconnectId:Long = Long.getLong(329840042,1301345271);
    private var _userDisconnect_userIdCodec:ICodec;

    public function StatisticsDMModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new StatisticsDMModelServer(IModel(this));
      var local1:ModelRegistry = ModelRegistry(OSGi.getInstance().getService(ModelRegistry));
      local1.registerModelConstructorCodec(this.modelId,this._protocol.getCodec(new TypeCodecInfo(StatisticsDMCC,false)));
      this._changeUserStat_userStatCodec = this._protocol.getCodec(new TypeCodecInfo(UserStat,false));
      this._refreshUsersStat_usersStatCodec = this._protocol.getCodec(new CollectionCodecInfo(new TypeCodecInfo(UserStat,false),false,1));
      this._userConnect_userIdCodec = this._protocol.getCodec(new TypeCodecInfo(Long,false));
      this._userConnect_usersInfoCodec = this._protocol.getCodec(new CollectionCodecInfo(new TypeCodecInfo(UserInfo,false),false,1));
      this._userDisconnect_userIdCodec = this._protocol.getCodec(new TypeCodecInfo(Long,false));
    }

    protected function getInitParam() : StatisticsDMCC {
      return StatisticsDMCC(initParams[Model.object]);
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._changeUserStatId:
          this.client.changeUserStat(UserStat(this._changeUserStat_userStatCodec.decode(param2)));
          break;
        case this._refreshUsersStatId:
          this.client.refreshUsersStat(this._refreshUsersStat_usersStatCodec.decode(param2) as Vector.<UserStat>);
          break;
        case this._userConnectId:
          this.client.userConnect(Long(this._userConnect_userIdCodec.decode(param2)),this._userConnect_usersInfoCodec.decode(param2) as Vector.<UserInfo>);
          break;
        case this._userDisconnectId:
          this.client.userDisconnect(Long(this._userDisconnect_userIdCodec.decode(param2)));
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
