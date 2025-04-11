package _codec.projects.tanks.client.battlefield.models.tankparts.weapons.common.discrete {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Byte;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.battlefield.models.tankparts.weapons.common.discrete.TargetHit;
  import projects.tanks.client.battlefield.types.Vector3d;

  public class CodecTargetHit implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_direction:ICodec;
    private var codec_localHitPoint:ICodec;
    private var codec_numberHits:ICodec;
    private var codec_target:ICodec;

    public function CodecTargetHit() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_direction = param1.getCodec(new TypeCodecInfo(Vector3d,false));
      this.codec_localHitPoint = param1.getCodec(new TypeCodecInfo(Vector3d,false));
      this.codec_numberHits = param1.getCodec(new TypeCodecInfo(Byte,false));
      this.codec_target = param1.getCodec(new TypeCodecInfo(IGameObject,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:TargetHit = new TargetHit();
      local2.direction = this.codec_direction.decode(param1) as Vector3d;
      local2.localHitPoint = this.codec_localHitPoint.decode(param1) as Vector3d;
      local2.numberHits = this.codec_numberHits.decode(param1) as int;
      local2.target = this.codec_target.decode(param1) as IGameObject;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:TargetHit = TargetHit(param2);
      this.codec_direction.encode(param1,local3.direction);
      this.codec_localHitPoint.encode(param1,local3.localHitPoint);
      this.codec_numberHits.encode(param1,local3.numberHits);
      this.codec_target.encode(param1,local3.target);
    }
  }
}
