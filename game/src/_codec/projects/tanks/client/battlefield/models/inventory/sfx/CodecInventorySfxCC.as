package _codec.projects.tanks.client.battlefield.models.inventory.sfx {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import platform.client.fp10.core.resource.types.SoundResource;
  import projects.tanks.client.battlefield.models.inventory.sfx.InventorySfxCC;

  public class CodecInventorySfxCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_daOffSound:ICodec;
    private var codec_daOnSound:ICodec;
    private var codec_ddOffSound:ICodec;
    private var codec_ddOnSound:ICodec;
    private var codec_healingSound:ICodec;
    private var codec_nitroOffSound:ICodec;
    private var codec_nitroOnSound:ICodec;
    private var codec_notReadySound:ICodec;
    private var codec_readySound:ICodec;

    public function CodecInventorySfxCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_daOffSound = param1.getCodec(new TypeCodecInfo(SoundResource,false));
      this.codec_daOnSound = param1.getCodec(new TypeCodecInfo(SoundResource,false));
      this.codec_ddOffSound = param1.getCodec(new TypeCodecInfo(SoundResource,false));
      this.codec_ddOnSound = param1.getCodec(new TypeCodecInfo(SoundResource,false));
      this.codec_healingSound = param1.getCodec(new TypeCodecInfo(SoundResource,false));
      this.codec_nitroOffSound = param1.getCodec(new TypeCodecInfo(SoundResource,false));
      this.codec_nitroOnSound = param1.getCodec(new TypeCodecInfo(SoundResource,false));
      this.codec_notReadySound = param1.getCodec(new TypeCodecInfo(SoundResource,false));
      this.codec_readySound = param1.getCodec(new TypeCodecInfo(SoundResource,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:InventorySfxCC = new InventorySfxCC();
      local2.daOffSound = this.codec_daOffSound.decode(param1) as SoundResource;
      local2.daOnSound = this.codec_daOnSound.decode(param1) as SoundResource;
      local2.ddOffSound = this.codec_ddOffSound.decode(param1) as SoundResource;
      local2.ddOnSound = this.codec_ddOnSound.decode(param1) as SoundResource;
      local2.healingSound = this.codec_healingSound.decode(param1) as SoundResource;
      local2.nitroOffSound = this.codec_nitroOffSound.decode(param1) as SoundResource;
      local2.nitroOnSound = this.codec_nitroOnSound.decode(param1) as SoundResource;
      local2.notReadySound = this.codec_notReadySound.decode(param1) as SoundResource;
      local2.readySound = this.codec_readySound.decode(param1) as SoundResource;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:InventorySfxCC = InventorySfxCC(param2);
      this.codec_daOffSound.encode(param1,local3.daOffSound);
      this.codec_daOnSound.encode(param1,local3.daOnSound);
      this.codec_ddOffSound.encode(param1,local3.ddOffSound);
      this.codec_ddOnSound.encode(param1,local3.ddOnSound);
      this.codec_healingSound.encode(param1,local3.healingSound);
      this.codec_nitroOffSound.encode(param1,local3.nitroOffSound);
      this.codec_nitroOnSound.encode(param1,local3.nitroOnSound);
      this.codec_notReadySound.encode(param1,local3.notReadySound);
      this.codec_readySound.encode(param1,local3.readySound);
    }
  }
}
