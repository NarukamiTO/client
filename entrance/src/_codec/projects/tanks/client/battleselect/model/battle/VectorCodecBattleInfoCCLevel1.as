package _codec.projects.tanks.client.battleselect.model.battle {
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.codec.OptionalCodecDecorator;
  import alternativa.protocol.impl.LengthCodecHelper;
  import alternativa.protocol.info.TypeCodecInfo;
  import projects.tanks.client.battleselect.model.battle.BattleInfoCC;

  public class VectorCodecBattleInfoCCLevel1 implements ICodec {
    private var elementCodec:ICodec;
    private var optionalElement:Boolean;

    public function VectorCodecBattleInfoCCLevel1(param1:Boolean) {
      super();
      this.optionalElement = param1;
    }

    public function init(param1:IProtocol) : void {
      this.elementCodec = param1.getCodec(new TypeCodecInfo(BattleInfoCC,false));
      if(this.optionalElement) {
        this.elementCodec = new OptionalCodecDecorator(this.elementCodec);
      }
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:int = LengthCodecHelper.decodeLength(param1);
      var local3:Vector.<BattleInfoCC> = new Vector.<BattleInfoCC>(local2,true);
      var local4:int = 0;
      while(local4 < local2) {
        local3[local4] = BattleInfoCC(this.elementCodec.decode(param1));
        local4++;
      }
      return local3;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      var local4:BattleInfoCC = null;
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:Vector.<BattleInfoCC> = Vector.<BattleInfoCC>(param2);
      var local5:int = int(local3.length);
      LengthCodecHelper.encodeLength(param1,local5);
      var local6:int = 0;
      while(local6 < local5) {
        this.elementCodec.encode(param1,local3[local6]);
        local6++;
      }
    }
  }
}
