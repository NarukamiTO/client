package _codec.projects.tanks.client.garage.models.user.present {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.garage.models.user.present.PresentItem;

  public class CodecPresentItem implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_banned:ICodec;
    private var codec_date:ICodec;
    private var codec_id:ICodec;
    private var codec_present:ICodec;
    private var codec_presenter:ICodec;
    private var codec_text:ICodec;

    public function CodecPresentItem() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_banned = param1.getCodec(new TypeCodecInfo(Boolean,false));
      this.codec_date = param1.getCodec(new TypeCodecInfo(Date,false));
      this.codec_id = param1.getCodec(new TypeCodecInfo(Long,false));
      this.codec_present = param1.getCodec(new TypeCodecInfo(IGameObject,false));
      this.codec_presenter = param1.getCodec(new TypeCodecInfo(Long,false));
      this.codec_text = param1.getCodec(new TypeCodecInfo(String,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:PresentItem = new PresentItem();
      local2.banned = this.codec_banned.decode(param1) as Boolean;
      local2.date = this.codec_date.decode(param1) as Date;
      local2.id = this.codec_id.decode(param1) as Long;
      local2.present = this.codec_present.decode(param1) as IGameObject;
      local2.presenter = this.codec_presenter.decode(param1) as Long;
      local2.text = this.codec_text.decode(param1) as String;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:PresentItem = PresentItem(param2);
      this.codec_banned.encode(param1,local3.banned);
      this.codec_date.encode(param1,local3.date);
      this.codec_id.encode(param1,local3.id);
      this.codec_present.encode(param1,local3.present);
      this.codec_presenter.encode(param1,local3.presenter);
      this.codec_text.encode(param1,local3.text);
    }
  }
}
