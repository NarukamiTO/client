package _codec.projects.tanks.client.battlefield.models.battle.battlefield.mine {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.CollectionCodecInfo;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Float;
  import platform.client.fp10.core.resource.types.MultiframeTextureResource;
  import platform.client.fp10.core.resource.types.SoundResource;
  import platform.client.fp10.core.resource.types.TextureResource;
  import projects.tanks.client.battlefield.models.battle.battlefield.mine.BattleMine;
  import projects.tanks.client.battlefield.models.battle.battlefield.mine.BattleMineCC;
  import projects.tanks.clients.flash.resources.resource.Tanks3DSResource;

  public class CodecBattleMineCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_activateSound:ICodec;
    private var codec_activateTimeMsec:ICodec;
    private var codec_battleMines:ICodec;
    private var codec_blueMineTexture:ICodec;
    private var codec_deactivateSound:ICodec;
    private var codec_enemyMineTexture:ICodec;
    private var codec_explosionMarkTexture:ICodec;
    private var codec_explosionSound:ICodec;
    private var codec_farVisibilityRadius:ICodec;
    private var codec_friendlyMineTexture:ICodec;
    private var codec_idleExplosionTexture:ICodec;
    private var codec_impactForce:ICodec;
    private var codec_mainExplosionTexture:ICodec;
    private var codec_minDistanceFromBase:ICodec;
    private var codec_model3ds:ICodec;
    private var codec_nearVisibilityRadius:ICodec;
    private var codec_radius:ICodec;
    private var codec_redMineTexture:ICodec;

    public function CodecBattleMineCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_activateSound = param1.getCodec(new TypeCodecInfo(SoundResource,false));
      this.codec_activateTimeMsec = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_battleMines = param1.getCodec(new CollectionCodecInfo(new TypeCodecInfo(BattleMine,false),false,1));
      this.codec_blueMineTexture = param1.getCodec(new TypeCodecInfo(TextureResource,false));
      this.codec_deactivateSound = param1.getCodec(new TypeCodecInfo(SoundResource,false));
      this.codec_enemyMineTexture = param1.getCodec(new TypeCodecInfo(TextureResource,false));
      this.codec_explosionMarkTexture = param1.getCodec(new TypeCodecInfo(TextureResource,false));
      this.codec_explosionSound = param1.getCodec(new TypeCodecInfo(SoundResource,false));
      this.codec_farVisibilityRadius = param1.getCodec(new TypeCodecInfo(Float,false));
      this.codec_friendlyMineTexture = param1.getCodec(new TypeCodecInfo(TextureResource,false));
      this.codec_idleExplosionTexture = param1.getCodec(new TypeCodecInfo(MultiframeTextureResource,false));
      this.codec_impactForce = param1.getCodec(new TypeCodecInfo(Float,false));
      this.codec_mainExplosionTexture = param1.getCodec(new TypeCodecInfo(MultiframeTextureResource,false));
      this.codec_minDistanceFromBase = param1.getCodec(new TypeCodecInfo(Float,false));
      this.codec_model3ds = param1.getCodec(new TypeCodecInfo(Tanks3DSResource,false));
      this.codec_nearVisibilityRadius = param1.getCodec(new TypeCodecInfo(Float,false));
      this.codec_radius = param1.getCodec(new TypeCodecInfo(Float,false));
      this.codec_redMineTexture = param1.getCodec(new TypeCodecInfo(TextureResource,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:BattleMineCC = new BattleMineCC();
      local2.activateSound = this.codec_activateSound.decode(param1) as SoundResource;
      local2.activateTimeMsec = this.codec_activateTimeMsec.decode(param1) as int;
      local2.battleMines = this.codec_battleMines.decode(param1) as Vector.<BattleMine>;
      local2.blueMineTexture = this.codec_blueMineTexture.decode(param1) as TextureResource;
      local2.deactivateSound = this.codec_deactivateSound.decode(param1) as SoundResource;
      local2.enemyMineTexture = this.codec_enemyMineTexture.decode(param1) as TextureResource;
      local2.explosionMarkTexture = this.codec_explosionMarkTexture.decode(param1) as TextureResource;
      local2.explosionSound = this.codec_explosionSound.decode(param1) as SoundResource;
      local2.farVisibilityRadius = this.codec_farVisibilityRadius.decode(param1) as Number;
      local2.friendlyMineTexture = this.codec_friendlyMineTexture.decode(param1) as TextureResource;
      local2.idleExplosionTexture = this.codec_idleExplosionTexture.decode(param1) as MultiframeTextureResource;
      local2.impactForce = this.codec_impactForce.decode(param1) as Number;
      local2.mainExplosionTexture = this.codec_mainExplosionTexture.decode(param1) as MultiframeTextureResource;
      local2.minDistanceFromBase = this.codec_minDistanceFromBase.decode(param1) as Number;
      local2.model3ds = this.codec_model3ds.decode(param1) as Tanks3DSResource;
      local2.nearVisibilityRadius = this.codec_nearVisibilityRadius.decode(param1) as Number;
      local2.radius = this.codec_radius.decode(param1) as Number;
      local2.redMineTexture = this.codec_redMineTexture.decode(param1) as TextureResource;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:BattleMineCC = BattleMineCC(param2);
      this.codec_activateSound.encode(param1,local3.activateSound);
      this.codec_activateTimeMsec.encode(param1,local3.activateTimeMsec);
      this.codec_battleMines.encode(param1,local3.battleMines);
      this.codec_blueMineTexture.encode(param1,local3.blueMineTexture);
      this.codec_deactivateSound.encode(param1,local3.deactivateSound);
      this.codec_enemyMineTexture.encode(param1,local3.enemyMineTexture);
      this.codec_explosionMarkTexture.encode(param1,local3.explosionMarkTexture);
      this.codec_explosionSound.encode(param1,local3.explosionSound);
      this.codec_farVisibilityRadius.encode(param1,local3.farVisibilityRadius);
      this.codec_friendlyMineTexture.encode(param1,local3.friendlyMineTexture);
      this.codec_idleExplosionTexture.encode(param1,local3.idleExplosionTexture);
      this.codec_impactForce.encode(param1,local3.impactForce);
      this.codec_mainExplosionTexture.encode(param1,local3.mainExplosionTexture);
      this.codec_minDistanceFromBase.encode(param1,local3.minDistanceFromBase);
      this.codec_model3ds.encode(param1,local3.model3ds);
      this.codec_nearVisibilityRadius.encode(param1,local3.nearVisibilityRadius);
      this.codec_radius.encode(param1,local3.radius);
      this.codec_redMineTexture.encode(param1,local3.redMineTexture);
    }
  }
}
