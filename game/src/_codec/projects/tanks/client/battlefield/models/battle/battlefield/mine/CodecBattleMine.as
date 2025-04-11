package _codec.projects.tanks.client.battlefield.models.battle.battlefield.mine {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import projects.tanks.client.battlefield.models.battle.battlefield.mine.BattleMine;
  import projects.tanks.client.battlefield.types.Vector3d;

  public class CodecBattleMine implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_activated:ICodec;
    private var codec_expirationMine:ICodec;
    private var codec_expirationTaskId:ICodec;
    private var codec_mineId:ICodec;
    private var codec_ownerId:ICodec;
    private var codec_position:ICodec;

    public function CodecBattleMine() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_activated = param1.getCodec(new TypeCodecInfo(Boolean,false));
      this.codec_expirationMine = param1.getCodec(new TypeCodecInfo(Boolean,false));
      this.codec_expirationTaskId = param1.getCodec(new TypeCodecInfo(Long,false));
      this.codec_mineId = param1.getCodec(new TypeCodecInfo(Long,false));
      this.codec_ownerId = param1.getCodec(new TypeCodecInfo(Long,false));
      this.codec_position = param1.getCodec(new TypeCodecInfo(Vector3d,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:BattleMine = new BattleMine();
      local2.activated = this.codec_activated.decode(param1) as Boolean;
      local2.expirationMine = this.codec_expirationMine.decode(param1) as Boolean;
      local2.expirationTaskId = this.codec_expirationTaskId.decode(param1) as Long;
      local2.mineId = this.codec_mineId.decode(param1) as Long;
      local2.ownerId = this.codec_ownerId.decode(param1) as Long;
      local2.position = this.codec_position.decode(param1) as Vector3d;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:BattleMine = BattleMine(param2);
      this.codec_activated.encode(param1,local3.activated);
      this.codec_expirationMine.encode(param1,local3.expirationMine);
      this.codec_expirationTaskId.encode(param1,local3.expirationTaskId);
      this.codec_mineId.encode(param1,local3.mineId);
      this.codec_ownerId.encode(param1,local3.ownerId);
      this.codec_position.encode(param1,local3.position);
    }
  }
}
