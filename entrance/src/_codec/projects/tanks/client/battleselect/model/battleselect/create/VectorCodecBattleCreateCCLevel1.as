package _codec.projects.tanks.client.battleselect.model.battleselect.create {
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.codec.OptionalCodecDecorator;
  import alternativa.protocol.impl.LengthCodecHelper;
  import alternativa.protocol.info.TypeCodecInfo;
  import projects.tanks.client.battleselect.model.battleselect.create.BattleCreateCC;

  public class VectorCodecBattleCreateCCLevel1 implements ICodec {
    private var elementCodec:ICodec;
    private var optionalElement:Boolean;

    public function VectorCodecBattleCreateCCLevel1(param1:Boolean) {
      super();
      this.optionalElement = param1;
    }

    public function init(param1:IProtocol) : void {
      this.elementCodec = param1.getCodec(new TypeCodecInfo(BattleCreateCC,false));
      if(this.optionalElement) {
        this.elementCodec = new OptionalCodecDecorator(this.elementCodec);
      }
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:int = LengthCodecHelper.decodeLength(param1);
      var local3:Vector.<BattleCreateCC> = new Vector.<BattleCreateCC>(local2,true);
      var local4:int = 0;
      while(local4 < local2) {
        local3[local4] = BattleCreateCC(this.elementCodec.decode(param1));
        local4++;
      }
      return local3;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      var local4:BattleCreateCC = null;
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:Vector.<BattleCreateCC> = Vector.<BattleCreateCC>(param2);
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
