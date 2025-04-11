package platform.client.core.general.spaces.osgi {
  import _codec.platform.client.core.general.spaces.loading.dispatcher.types.CodecObjectsData;
  import _codec.platform.client.core.general.spaces.loading.dispatcher.types.CodecObjectsDependencies;
  import _codec.platform.client.core.general.spaces.loading.dispatcher.types.VectorCodecObjectsDataLevel1;
  import _codec.platform.client.core.general.spaces.loading.dispatcher.types.VectorCodecObjectsDependenciesLevel1;
  import _codec.platform.client.core.general.spaces.loading.modelconstructors.CodecModelData;
  import _codec.platform.client.core.general.spaces.loading.modelconstructors.VectorCodecModelDataLevel1;
  import alternativa.osgi.OSGi;
  import alternativa.osgi.bundle.IBundleActivator;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.codec.OptionalCodecDecorator;
  import alternativa.protocol.info.CollectionCodecInfo;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import platform.client.core.general.spaces.loading.dispatcher.types.ObjectsData;
  import platform.client.core.general.spaces.loading.dispatcher.types.ObjectsDependencies;
  import platform.client.core.general.spaces.loading.modelconstructors.ModelData;
  import platform.client.fp10.core.registry.ModelRegistry;

  public class Activator implements IBundleActivator {
    public static var osgi:OSGi;

    public function Activator() {
      super();
    }

    public function start(param1:OSGi) : void {
      var local4:ICodec = null;
      osgi = param1;
      var local2:ModelRegistry = ModelRegistry(OSGi.getInstance().getService(ModelRegistry));
      local2.register(Long.getLong(191355032,163351191),Long.getLong(748816660,1488436371));
      local2.register(Long.getLong(191355032,163351191),Long.getLong(1779039460,1862164506));
      local2.register(Long.getLong(191355032,163351191),Long.getLong(2104499555,54326167));
      var local3:IProtocol = IProtocol(osgi.getService(IProtocol));
      local4 = new CodecObjectsData();
      local3.registerCodec(new TypeCodecInfo(ObjectsData,false),local4);
      local3.registerCodec(new TypeCodecInfo(ObjectsData,true),new OptionalCodecDecorator(local4));
      local4 = new CodecObjectsDependencies();
      local3.registerCodec(new TypeCodecInfo(ObjectsDependencies,false),local4);
      local3.registerCodec(new TypeCodecInfo(ObjectsDependencies,true),new OptionalCodecDecorator(local4));
      local4 = new CodecModelData();
      local3.registerCodec(new TypeCodecInfo(ModelData,false),local4);
      local3.registerCodec(new TypeCodecInfo(ModelData,true),new OptionalCodecDecorator(local4));
      local4 = new VectorCodecObjectsDataLevel1(false);
      local3.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(ObjectsData,false),false,1),local4);
      local3.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(ObjectsData,false),true,1),new OptionalCodecDecorator(local4));
      local4 = new VectorCodecObjectsDataLevel1(true);
      local3.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(ObjectsData,true),false,1),local4);
      local3.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(ObjectsData,true),true,1),new OptionalCodecDecorator(local4));
      local4 = new VectorCodecObjectsDependenciesLevel1(false);
      local3.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(ObjectsDependencies,false),false,1),local4);
      local3.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(ObjectsDependencies,false),true,1),new OptionalCodecDecorator(local4));
      local4 = new VectorCodecObjectsDependenciesLevel1(true);
      local3.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(ObjectsDependencies,true),false,1),local4);
      local3.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(ObjectsDependencies,true),true,1),new OptionalCodecDecorator(local4));
      local4 = new VectorCodecModelDataLevel1(false);
      local3.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(ModelData,false),false,1),local4);
      local3.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(ModelData,false),true,1),new OptionalCodecDecorator(local4));
      local4 = new VectorCodecModelDataLevel1(true);
      local3.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(ModelData,true),false,1),local4);
      local3.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(ModelData,true),true,1),new OptionalCodecDecorator(local4));
    }

    public function stop(param1:OSGi) : void {
    }
  }
}
