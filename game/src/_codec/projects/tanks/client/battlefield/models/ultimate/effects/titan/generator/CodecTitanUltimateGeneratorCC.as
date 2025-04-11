package _codec.projects.tanks.client.battlefield.models.ultimate.effects.titan.generator {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.CollectionCodecInfo;
  import alternativa.protocol.info.EnumCodecInfo;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Float;
  import alternativa.types.Long;
  import platform.client.fp10.core.resource.types.MultiframeTextureResource;
  import platform.client.fp10.core.resource.types.SoundResource;
  import platform.client.fp10.core.resource.types.TextureResource;
  import projects.tanks.client.battlefield.models.ultimate.effects.titan.generator.TitanUltimateGeneratorCC;
  import projects.tanks.client.battleservice.model.battle.team.BattleTeam;
  import projects.tanks.clients.flash.resources.resource.Tanks3DSResource;

  public class CodecTitanUltimateGeneratorCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_blueCell:ICodec;
    private var codec_blueRay:ICodec;
    private var codec_blueRayTip:ICodec;
    private var codec_blueSimpleShield:ICodec;
    private var codec_blueSphere:ICodec;
    private var codec_cell:ICodec;
    private var codec_coveredTanksIds:ICodec;
    private var codec_generatorActivationSound:ICodec;
    private var codec_generatorDeactivationSound:ICodec;
    private var codec_generatorLoopSound:ICodec;
    private var codec_generatorTeam:ICodec;
    private var codec_geosphere:ICodec;
    private var codec_ray:ICodec;
    private var codec_rayTip:ICodec;
    private var codec_redCell:ICodec;
    private var codec_redRay:ICodec;
    private var codec_redRayTip:ICodec;
    private var codec_redSimpleShield:ICodec;
    private var codec_redSphere:ICodec;
    private var codec_shieldOffSound:ICodec;
    private var codec_shieldOnSound:ICodec;
    private var codec_simpleShield:ICodec;
    private var codec_sphere:ICodec;
    private var codec_zoneRadiusFakeReducing:ICodec;

    public function CodecTitanUltimateGeneratorCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_blueCell = param1.getCodec(new TypeCodecInfo(TextureResource,true));
      this.codec_blueRay = param1.getCodec(new TypeCodecInfo(TextureResource,false));
      this.codec_blueRayTip = param1.getCodec(new TypeCodecInfo(TextureResource,false));
      this.codec_blueSimpleShield = param1.getCodec(new TypeCodecInfo(TextureResource,true));
      this.codec_blueSphere = param1.getCodec(new TypeCodecInfo(MultiframeTextureResource,false));
      this.codec_cell = param1.getCodec(new TypeCodecInfo(TextureResource,true));
      this.codec_coveredTanksIds = param1.getCodec(new CollectionCodecInfo(new TypeCodecInfo(Long,false),false,1));
      this.codec_generatorActivationSound = param1.getCodec(new TypeCodecInfo(SoundResource,false));
      this.codec_generatorDeactivationSound = param1.getCodec(new TypeCodecInfo(SoundResource,false));
      this.codec_generatorLoopSound = param1.getCodec(new TypeCodecInfo(SoundResource,false));
      this.codec_generatorTeam = param1.getCodec(new EnumCodecInfo(BattleTeam,false));
      this.codec_geosphere = param1.getCodec(new TypeCodecInfo(Tanks3DSResource,true));
      this.codec_ray = param1.getCodec(new TypeCodecInfo(TextureResource,false));
      this.codec_rayTip = param1.getCodec(new TypeCodecInfo(TextureResource,false));
      this.codec_redCell = param1.getCodec(new TypeCodecInfo(TextureResource,true));
      this.codec_redRay = param1.getCodec(new TypeCodecInfo(TextureResource,false));
      this.codec_redRayTip = param1.getCodec(new TypeCodecInfo(TextureResource,false));
      this.codec_redSimpleShield = param1.getCodec(new TypeCodecInfo(TextureResource,true));
      this.codec_redSphere = param1.getCodec(new TypeCodecInfo(MultiframeTextureResource,false));
      this.codec_shieldOffSound = param1.getCodec(new TypeCodecInfo(SoundResource,false));
      this.codec_shieldOnSound = param1.getCodec(new TypeCodecInfo(SoundResource,false));
      this.codec_simpleShield = param1.getCodec(new TypeCodecInfo(TextureResource,true));
      this.codec_sphere = param1.getCodec(new TypeCodecInfo(MultiframeTextureResource,false));
      this.codec_zoneRadiusFakeReducing = param1.getCodec(new TypeCodecInfo(Float,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:TitanUltimateGeneratorCC = new TitanUltimateGeneratorCC();
      local2.blueCell = this.codec_blueCell.decode(param1) as TextureResource;
      local2.blueRay = this.codec_blueRay.decode(param1) as TextureResource;
      local2.blueRayTip = this.codec_blueRayTip.decode(param1) as TextureResource;
      local2.blueSimpleShield = this.codec_blueSimpleShield.decode(param1) as TextureResource;
      local2.blueSphere = this.codec_blueSphere.decode(param1) as MultiframeTextureResource;
      local2.cell = this.codec_cell.decode(param1) as TextureResource;
      local2.coveredTanksIds = this.codec_coveredTanksIds.decode(param1) as Vector.<Long>;
      local2.generatorActivationSound = this.codec_generatorActivationSound.decode(param1) as SoundResource;
      local2.generatorDeactivationSound = this.codec_generatorDeactivationSound.decode(param1) as SoundResource;
      local2.generatorLoopSound = this.codec_generatorLoopSound.decode(param1) as SoundResource;
      local2.generatorTeam = this.codec_generatorTeam.decode(param1) as BattleTeam;
      local2.geosphere = this.codec_geosphere.decode(param1) as Tanks3DSResource;
      local2.ray = this.codec_ray.decode(param1) as TextureResource;
      local2.rayTip = this.codec_rayTip.decode(param1) as TextureResource;
      local2.redCell = this.codec_redCell.decode(param1) as TextureResource;
      local2.redRay = this.codec_redRay.decode(param1) as TextureResource;
      local2.redRayTip = this.codec_redRayTip.decode(param1) as TextureResource;
      local2.redSimpleShield = this.codec_redSimpleShield.decode(param1) as TextureResource;
      local2.redSphere = this.codec_redSphere.decode(param1) as MultiframeTextureResource;
      local2.shieldOffSound = this.codec_shieldOffSound.decode(param1) as SoundResource;
      local2.shieldOnSound = this.codec_shieldOnSound.decode(param1) as SoundResource;
      local2.simpleShield = this.codec_simpleShield.decode(param1) as TextureResource;
      local2.sphere = this.codec_sphere.decode(param1) as MultiframeTextureResource;
      local2.zoneRadiusFakeReducing = this.codec_zoneRadiusFakeReducing.decode(param1) as Number;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:TitanUltimateGeneratorCC = TitanUltimateGeneratorCC(param2);
      this.codec_blueCell.encode(param1,local3.blueCell);
      this.codec_blueRay.encode(param1,local3.blueRay);
      this.codec_blueRayTip.encode(param1,local3.blueRayTip);
      this.codec_blueSimpleShield.encode(param1,local3.blueSimpleShield);
      this.codec_blueSphere.encode(param1,local3.blueSphere);
      this.codec_cell.encode(param1,local3.cell);
      this.codec_coveredTanksIds.encode(param1,local3.coveredTanksIds);
      this.codec_generatorActivationSound.encode(param1,local3.generatorActivationSound);
      this.codec_generatorDeactivationSound.encode(param1,local3.generatorDeactivationSound);
      this.codec_generatorLoopSound.encode(param1,local3.generatorLoopSound);
      this.codec_generatorTeam.encode(param1,local3.generatorTeam);
      this.codec_geosphere.encode(param1,local3.geosphere);
      this.codec_ray.encode(param1,local3.ray);
      this.codec_rayTip.encode(param1,local3.rayTip);
      this.codec_redCell.encode(param1,local3.redCell);
      this.codec_redRay.encode(param1,local3.redRay);
      this.codec_redRayTip.encode(param1,local3.redRayTip);
      this.codec_redSimpleShield.encode(param1,local3.redSimpleShield);
      this.codec_redSphere.encode(param1,local3.redSphere);
      this.codec_shieldOffSound.encode(param1,local3.shieldOffSound);
      this.codec_shieldOnSound.encode(param1,local3.shieldOnSound);
      this.codec_simpleShield.encode(param1,local3.simpleShield);
      this.codec_sphere.encode(param1,local3.sphere);
      this.codec_zoneRadiusFakeReducing.encode(param1,local3.zoneRadiusFakeReducing);
    }
  }
}
