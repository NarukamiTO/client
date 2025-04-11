package projects.tanks.client.panel.model.profile.userproperties {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.registry.ModelRegistry;
  import projects.tanks.client.users.model.userbattlestatistics.rank.RankBounds;

  public class UserPropertiesModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:UserPropertiesModelServer;

    private var client:IUserPropertiesModelBase = IUserPropertiesModelBase(this);
    private var modelId:Long = Long.getLong(440843623,678812097);
    private var _changeCrystalId:Long = Long.getLong(64279002,881084048);
    private var _changeCrystal_crystalsCodec:ICodec;
    private var _onJoinClanId:Long = Long.getLong(1831025596,2175819);
    private var _onLeaveClanId:Long = Long.getLong(927218296,-2113500728);
    private var _updateGearScoreId:Long = Long.getLong(1310531887,1919847900);
    private var _updateGearScore_gearScoreCodec:ICodec;
    private var _updateRankId:Long = Long.getLong(1830988099,1665874005);
    private var _updateRank_rankCodec:ICodec;
    private var _updateRank_scoreCodec:ICodec;
    private var _updateRank_boundsCodec:ICodec;
    private var _updateRank_bonusCrystalsCodec:ICodec;
    private var _updateRank_canCreateGroupCodec:ICodec;
    private var _updateRank_forceUpRankForNewbiesCodec:ICodec;
    private var _updateScoreId:Long = Long.getLong(926056233,101502221);
    private var _updateScore_scoreCodec:ICodec;
    private var _updateUidId:Long = Long.getLong(197611464,1577755407);
    private var _updateUid_uidCodec:ICodec;
    private var _updateUserRatingId:Long = Long.getLong(1971693857,-974448007);
    private var _updateUserRating_userRatingCodec:ICodec;

    public function UserPropertiesModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new UserPropertiesModelServer(IModel(this));
      var local1:ModelRegistry = ModelRegistry(OSGi.getInstance().getService(ModelRegistry));
      local1.registerModelConstructorCodec(this.modelId,this._protocol.getCodec(new TypeCodecInfo(UserPropertiesCC,false)));
      this._changeCrystal_crystalsCodec = this._protocol.getCodec(new TypeCodecInfo(int,false));
      this._updateGearScore_gearScoreCodec = this._protocol.getCodec(new TypeCodecInfo(int,false));
      this._updateRank_rankCodec = this._protocol.getCodec(new TypeCodecInfo(int,false));
      this._updateRank_scoreCodec = this._protocol.getCodec(new TypeCodecInfo(int,false));
      this._updateRank_boundsCodec = this._protocol.getCodec(new TypeCodecInfo(RankBounds,false));
      this._updateRank_bonusCrystalsCodec = this._protocol.getCodec(new TypeCodecInfo(int,false));
      this._updateRank_canCreateGroupCodec = this._protocol.getCodec(new TypeCodecInfo(Boolean,false));
      this._updateRank_forceUpRankForNewbiesCodec = this._protocol.getCodec(new TypeCodecInfo(Boolean,false));
      this._updateScore_scoreCodec = this._protocol.getCodec(new TypeCodecInfo(int,false));
      this._updateUid_uidCodec = this._protocol.getCodec(new TypeCodecInfo(String,false));
      this._updateUserRating_userRatingCodec = this._protocol.getCodec(new TypeCodecInfo(int,false));
    }

    protected function getInitParam() : UserPropertiesCC {
      return UserPropertiesCC(initParams[Model.object]);
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._changeCrystalId:
          this.client.changeCrystal(int(this._changeCrystal_crystalsCodec.decode(param2)));
          break;
        case this._onJoinClanId:
          this.client.onJoinClan();
          break;
        case this._onLeaveClanId:
          this.client.onLeaveClan();
          break;
        case this._updateGearScoreId:
          this.client.updateGearScore(int(this._updateGearScore_gearScoreCodec.decode(param2)));
          break;
        case this._updateRankId:
          this.client.updateRank(int(this._updateRank_rankCodec.decode(param2)),int(this._updateRank_scoreCodec.decode(param2)),RankBounds(this._updateRank_boundsCodec.decode(param2)),int(this._updateRank_bonusCrystalsCodec.decode(param2)),Boolean(this._updateRank_canCreateGroupCodec.decode(param2)),Boolean(this._updateRank_forceUpRankForNewbiesCodec.decode(param2)));
          break;
        case this._updateScoreId:
          this.client.updateScore(int(this._updateScore_scoreCodec.decode(param2)));
          break;
        case this._updateUidId:
          this.client.updateUid(String(this._updateUid_uidCodec.decode(param2)));
          break;
        case this._updateUserRatingId:
          this.client.updateUserRating(int(this._updateUserRating_userRatingCodec.decode(param2)));
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
