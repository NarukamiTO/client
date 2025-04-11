package _codec.projects.tanks.client.chat.models.news.showing {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import projects.tanks.client.chat.models.news.showing.NewsItemData;

  public class CodecNewsItemData implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_dateInSeconds:ICodec;
    private var codec_description:ICodec;
    private var codec_endDate:ICodec;
    private var codec_header:ICodec;
    private var codec_id:ICodec;
    private var codec_imageUrl:ICodec;

    public function CodecNewsItemData() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_dateInSeconds = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_description = param1.getCodec(new TypeCodecInfo(String,false));
      this.codec_endDate = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_header = param1.getCodec(new TypeCodecInfo(String,false));
      this.codec_id = param1.getCodec(new TypeCodecInfo(Long,false));
      this.codec_imageUrl = param1.getCodec(new TypeCodecInfo(String,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:NewsItemData = new NewsItemData();
      local2.dateInSeconds = this.codec_dateInSeconds.decode(param1) as int;
      local2.description = this.codec_description.decode(param1) as String;
      local2.endDate = this.codec_endDate.decode(param1) as int;
      local2.header = this.codec_header.decode(param1) as String;
      local2.id = this.codec_id.decode(param1) as Long;
      local2.imageUrl = this.codec_imageUrl.decode(param1) as String;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:NewsItemData = NewsItemData(param2);
      this.codec_dateInSeconds.encode(param1,local3.dateInSeconds);
      this.codec_description.encode(param1,local3.description);
      this.codec_endDate.encode(param1,local3.endDate);
      this.codec_header.encode(param1,local3.header);
      this.codec_id.encode(param1,local3.id);
      this.codec_imageUrl.encode(param1,local3.imageUrl);
    }
  }
}
