package _codec.projects.tanks.client.battlefield.models.effects.description {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.EnumCodecInfo;
  import alternativa.protocol.info.TypeCodecInfo;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.battlefield.models.effects.description.EffectCategory;
  import projects.tanks.client.battlefield.models.effects.description.EffectDescriptionCC;

  public class CodecEffectDescriptionCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_category:ICodec;
    private var codec_index:ICodec;
    private var codec_tank:ICodec;

    public function CodecEffectDescriptionCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_category = param1.getCodec(new EnumCodecInfo(EffectCategory,false));
      this.codec_index = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_tank = param1.getCodec(new TypeCodecInfo(IGameObject,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:EffectDescriptionCC = new EffectDescriptionCC();
      local2.category = this.codec_category.decode(param1) as EffectCategory;
      local2.index = this.codec_index.decode(param1) as int;
      local2.tank = this.codec_tank.decode(param1) as IGameObject;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:EffectDescriptionCC = EffectDescriptionCC(param2);
      this.codec_category.encode(param1,local3.category);
      this.codec_index.encode(param1,local3.index);
      this.codec_tank.encode(param1,local3.tank);
    }
  }
}
