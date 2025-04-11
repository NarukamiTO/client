package _codec.projects.tanks.client.battlefield.models.tankparts.sfx.lighting.entity {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.CollectionCodecInfo;
  import alternativa.protocol.info.TypeCodecInfo;
  import projects.tanks.client.battlefield.models.tankparts.sfx.lighting.entity.LightingEffectEntity;
  import projects.tanks.client.battlefield.models.tankparts.sfx.lighting.entity.LightingSFXEntity;

  public class CodecLightingSFXEntity implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_effects:ICodec;

    public function CodecLightingSFXEntity() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_effects = param1.getCodec(new CollectionCodecInfo(new TypeCodecInfo(LightingEffectEntity,false),false,1));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:LightingSFXEntity = new LightingSFXEntity();
      local2.effects = this.codec_effects.decode(param1) as Vector.<LightingEffectEntity>;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:LightingSFXEntity = LightingSFXEntity(param2);
      this.codec_effects.encode(param1,local3.effects);
    }
  }
}
