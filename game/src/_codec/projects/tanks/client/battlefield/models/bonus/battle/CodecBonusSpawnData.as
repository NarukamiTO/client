package _codec.projects.tanks.client.battlefield.models.bonus.battle {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.battlefield.models.bonus.battle.BonusSpawnData;
  import projects.tanks.client.battlefield.types.Vector3d;

  public class CodecBonusSpawnData implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_battleBonusObject:ICodec;
    private var codec_bonusId:ICodec;
    private var codec_lifeTime:ICodec;
    private var codec_spawnPosition:ICodec;

    public function CodecBonusSpawnData() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_battleBonusObject = param1.getCodec(new TypeCodecInfo(IGameObject,false));
      this.codec_bonusId = param1.getCodec(new TypeCodecInfo(Long,false));
      this.codec_lifeTime = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_spawnPosition = param1.getCodec(new TypeCodecInfo(Vector3d,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:BonusSpawnData = new BonusSpawnData();
      local2.battleBonusObject = this.codec_battleBonusObject.decode(param1) as IGameObject;
      local2.bonusId = this.codec_bonusId.decode(param1) as Long;
      local2.lifeTime = this.codec_lifeTime.decode(param1) as int;
      local2.spawnPosition = this.codec_spawnPosition.decode(param1) as Vector3d;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:BonusSpawnData = BonusSpawnData(param2);
      this.codec_battleBonusObject.encode(param1,local3.battleBonusObject);
      this.codec_bonusId.encode(param1,local3.bonusId);
      this.codec_lifeTime.encode(param1,local3.lifeTime);
      this.codec_spawnPosition.encode(param1,local3.spawnPosition);
    }
  }
}
