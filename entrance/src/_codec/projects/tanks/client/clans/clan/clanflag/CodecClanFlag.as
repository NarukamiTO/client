package _codec.projects.tanks.client.clans.clan.clanflag {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import platform.client.fp10.core.resource.types.ImageResource;
  import projects.tanks.client.clans.clan.clanflag.ClanFlag;

  public class CodecClanFlag implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_flagImage:ICodec;
    private var codec_id:ICodec;
    private var codec_name:ICodec;

    public function CodecClanFlag() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_flagImage = param1.getCodec(new TypeCodecInfo(ImageResource,false));
      this.codec_id = param1.getCodec(new TypeCodecInfo(Long,false));
      this.codec_name = param1.getCodec(new TypeCodecInfo(String,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:ClanFlag = new ClanFlag();
      local2.flagImage = this.codec_flagImage.decode(param1) as ImageResource;
      local2.id = this.codec_id.decode(param1) as Long;
      local2.name = this.codec_name.decode(param1) as String;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:ClanFlag = ClanFlag(param2);
      this.codec_flagImage.encode(param1,local3.flagImage);
      this.codec_id.encode(param1,local3.id);
      this.codec_name.encode(param1,local3.name);
    }
  }
}
