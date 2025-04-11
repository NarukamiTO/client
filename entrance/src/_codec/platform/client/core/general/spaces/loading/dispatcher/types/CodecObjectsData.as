package _codec.platform.client.core.general.spaces.loading.dispatcher.types {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.CollectionCodecInfo;
  import alternativa.protocol.info.TypeCodecInfo;
  import platform.client.core.general.spaces.loading.dispatcher.types.ObjectsData;
  import platform.client.core.general.spaces.loading.modelconstructors.ModelData;
  import platform.client.fp10.core.type.IGameObject;

  public class CodecObjectsData implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_modelsData:ICodec;
    private var codec_objects:ICodec;

    public function CodecObjectsData() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_modelsData = param1.getCodec(new CollectionCodecInfo(new TypeCodecInfo(ModelData,false),false,1));
      this.codec_objects = param1.getCodec(new CollectionCodecInfo(new TypeCodecInfo(IGameObject,false),false,1));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:ObjectsData = new ObjectsData();
      local2.modelsData = this.codec_modelsData.decode(param1) as Vector.<ModelData>;
      local2.objects = this.codec_objects.decode(param1) as Vector.<IGameObject>;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:ObjectsData = ObjectsData(param2);
      this.codec_modelsData.encode(param1,local3.modelsData);
      this.codec_objects.encode(param1,local3.objects);
    }
  }
}
