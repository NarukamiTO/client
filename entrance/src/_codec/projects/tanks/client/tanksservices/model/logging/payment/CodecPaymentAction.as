package _codec.projects.tanks.client.tanksservices.model.logging.payment {
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import projects.tanks.client.tanksservices.model.logging.payment.PaymentAction;

  public class CodecPaymentAction implements ICodec {
    public function CodecPaymentAction() {
      super();
    }

    public function init(param1:IProtocol) : void {
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:PaymentAction = null;
      var local3:int = int(param1.reader.readInt());
      switch(local3) {
        case 0:
          local2 = PaymentAction.OPEN_PAYMENT;
          break;
        case 1:
          local2 = PaymentAction.COUNTRY_SELECT;
          break;
        case 2:
          local2 = PaymentAction.MODE_CHOOSE;
          break;
        case 3:
          local2 = PaymentAction.ITEM_CHOOSE;
          break;
        case 4:
          local2 = PaymentAction.CLOSE_PAYMENT;
          break;
        case 5:
          local2 = PaymentAction.PROCEED;
      }
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:int = int(param2.value);
      param1.writer.writeInt(local3);
    }
  }
}
