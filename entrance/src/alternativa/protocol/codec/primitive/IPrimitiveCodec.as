package alternativa.protocol.codec.primitive {
  import alternativa.protocol.ICodec;

  public interface IPrimitiveCodec extends ICodec {
    function nullValue() : Object;
  }
}
