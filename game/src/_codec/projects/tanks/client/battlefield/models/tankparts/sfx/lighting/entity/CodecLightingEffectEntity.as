package _codec.projects.tanks.client.battlefield.models.tankparts.sfx.lighting.entity {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.CollectionCodecInfo;
  import alternativa.protocol.info.TypeCodecInfo;
  import projects.tanks.client.battlefield.models.tankparts.sfx.lighting.entity.LightEffectItem;
  import projects.tanks.client.battlefield.models.tankparts.sfx.lighting.entity.LightingEffectEntity;

  public class CodecLightingEffectEntity implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_effectName:ICodec;
    private var codec_items:ICodec;

    public function CodecLightingEffectEntity() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_effectName = param1.getCodec(new TypeCodecInfo(String,false));
      this.codec_items = param1.getCodec(new CollectionCodecInfo(new TypeCodecInfo(LightEffectItem,false),false,1));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:LightingEffectEntity = new LightingEffectEntity();
      local2.effectName = this.codec_effectName.decode(param1) as String;
      local2.items = this.codec_items.decode(param1) as Vector.<LightEffectItem>;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:LightingEffectEntity = LightingEffectEntity(param2);
      this.codec_effectName.encode(param1,local3.effectName);
      this.codec_items.encode(param1,local3.items);
    }
  }
}
