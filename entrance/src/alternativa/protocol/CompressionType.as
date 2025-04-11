package alternativa.protocol {
  public class CompressionType {
    public static var NONE:CompressionType = new CompressionType();
    public static var DEFLATE:CompressionType = new CompressionType();
    public static var DEFLATE_AUTO:CompressionType = new CompressionType();

    public function CompressionType() {
      super();
    }
  }
}
