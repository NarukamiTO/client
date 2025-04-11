package _codec.projects.tanks.client.battleselect.model.battle.param {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.battleselect.model.battle.param.BattleParamInfoCC;
  import projects.tanks.client.battleservice.BattleCreateParameters;

  public class CodecBattleParamInfoCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_map:ICodec;
    private var codec_params:ICodec;

    public function CodecBattleParamInfoCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_map = param1.getCodec(new TypeCodecInfo(IGameObject,false));
      this.codec_params = param1.getCodec(new TypeCodecInfo(BattleCreateParameters,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:BattleParamInfoCC = new BattleParamInfoCC();
      local2.map = this.codec_map.decode(param1) as IGameObject;
      local2.params = this.codec_params.decode(param1) as BattleCreateParameters;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:BattleParamInfoCC = BattleParamInfoCC(param2);
      this.codec_map.encode(param1,local3.map);
      this.codec_params.encode(param1,local3.params);
    }
  }
}
