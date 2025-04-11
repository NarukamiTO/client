package platform.clients.fp10.libraries.alternativaclientflash {
  import _codec.platform.client.fp10.core.resource.types.VectorCodecImageResourceLevel1;
  import _codec.platform.client.fp10.core.resource.types.VectorCodecMultiframeTextureResourceLevel1;
  import _codec.platform.client.fp10.core.resource.types.VectorCodecTextureResourceLevel1;
  import _codec.platform.client.fp10.core.type.VectorCodecIGameObjectLevel1;
  import alternativa.osgi.OSGi;
  import alternativa.osgi.bundle.IBundleActivator;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.osgi.service.command.CommandService;
  import alternativa.osgi.service.display.IDisplay;
  import alternativa.osgi.service.launcherparams.ILauncherParams;
  import alternativa.osgi.service.locale.ILocaleService;
  import alternativa.osgi.service.logging.LogService;
  import alternativa.osgi.service.network.INetworkService;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.codec.OptionalCodecDecorator;
  import alternativa.protocol.impl.Protocol;
  import alternativa.protocol.info.CollectionCodecInfo;
  import alternativa.protocol.info.TypeCodecInfo;
  import com.hurlant.crypto.tls.TLSEngine;
  import com.hurlant.crypto.tls.TLSSecurityParameters;
  import com.hurlant.crypto.tls.TLSSocket;
  import platform.client.fp10.core.CoreCommands;
  import platform.client.fp10.core.logging.serverlog.UncaughtErrorServerLogImpl;
  import platform.client.fp10.core.model.IObjectLoadListener;
  import platform.client.fp10.core.model.IObjectLoadListenerAdapt;
  import platform.client.fp10.core.model.IObjectLoadListenerEvents;
  import platform.client.fp10.core.model.ObjectLoadListener;
  import platform.client.fp10.core.model.ObjectLoadListenerAdapt;
  import platform.client.fp10.core.model.ObjectLoadListenerEvents;
  import platform.client.fp10.core.model.ObjectLoadPostListener;
  import platform.client.fp10.core.model.ObjectLoadPostListenerAdapt;
  import platform.client.fp10.core.model.ObjectLoadPostListenerEvents;
  import platform.client.fp10.core.model.ObjectUnloadListener;
  import platform.client.fp10.core.model.ObjectUnloadListenerAdapt;
  import platform.client.fp10.core.model.ObjectUnloadListenerEvents;
  import platform.client.fp10.core.model.ObjectUnloadPostListener;
  import platform.client.fp10.core.model.ObjectUnloadPostListenerAdapt;
  import platform.client.fp10.core.model.ObjectUnloadPostListenerEvents;
  import platform.client.fp10.core.network.command.control.server.OpenSpaceCommand;
  import platform.client.fp10.core.network.connection.ControlConnectionSender;
  import platform.client.fp10.core.network.connection.SocketConnection;
  import platform.client.fp10.core.network.handler.ControlCommandHandler;
  import platform.client.fp10.core.network.handler.SpaceCommandHandler;
  import platform.client.fp10.core.protocol.codec.ControlRootCodec;
  import platform.client.fp10.core.protocol.codec.GameObjectCodec;
  import platform.client.fp10.core.registry.GameTypeRegistry;
  import platform.client.fp10.core.registry.ModelRegistry;
  import platform.client.fp10.core.registry.ResourceRegistry;
  import platform.client.fp10.core.registry.SpaceRegistry;
  import platform.client.fp10.core.registry.impl.ModelsRegistryImpl;
  import platform.client.fp10.core.registry.impl.ResourceRegistryImpl;
  import platform.client.fp10.core.resource.BatchResourceLoader;
  import platform.client.fp10.core.resource.IResourceLoader;
  import platform.client.fp10.core.resource.Resource;
  import platform.client.fp10.core.resource.ResourceLoader;
  import platform.client.fp10.core.resource.types.ImageResource;
  import platform.client.fp10.core.resource.types.LocalizedImageResource;
  import platform.client.fp10.core.resource.types.MultiframeTextureResource;
  import platform.client.fp10.core.resource.types.TextureResource;
  import platform.client.fp10.core.service.IResourceTimer;
  import platform.client.fp10.core.service.address.AddressService;
  import platform.client.fp10.core.service.address.impl.AddressServiceFakeImpl;
  import platform.client.fp10.core.service.errormessage.IErrorMessageService;
  import platform.client.fp10.core.service.localstorage.IResourceLocalStorage;
  import platform.client.fp10.core.service.transport.ITransportService;
  import platform.client.fp10.core.type.IGameObject;
  import platform.client.fp10.core.type.impl.GameObject;
  import platform.client.fp10.core.type.impl.Space;

  public class Activator implements IBundleActivator {
    public static var osgi:OSGi;

    public function Activator() {
      super();
    }

    public function start(param1:OSGi) : void {
      var modelRegisterAdapt:ModelRegistry;
      var codec:ICodec = null;
      var _osgi:OSGi = param1;
      osgi = _osgi;
      var protocol:IProtocol = Protocol.defaultInstance;
      codec = new VectorCodecImageResourceLevel1(false);
      protocol.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(ImageResource,false),false,1),codec);
      protocol.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(ImageResource,false),true,1),new OptionalCodecDecorator(codec));
      codec = new VectorCodecImageResourceLevel1(true);
      protocol.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(ImageResource,true),false,1),codec);
      protocol.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(ImageResource,true),true,1),new OptionalCodecDecorator(codec));
      codec = new VectorCodecMultiframeTextureResourceLevel1(false);
      protocol.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(MultiframeTextureResource,false),false,1),codec);
      protocol.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(MultiframeTextureResource,false),true,1),new OptionalCodecDecorator(codec));
      codec = new VectorCodecMultiframeTextureResourceLevel1(true);
      protocol.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(MultiframeTextureResource,true),false,1),codec);
      protocol.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(MultiframeTextureResource,true),true,1),new OptionalCodecDecorator(codec));
      codec = new VectorCodecTextureResourceLevel1(false);
      protocol.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(TextureResource,false),false,1),codec);
      protocol.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(TextureResource,false),true,1),new OptionalCodecDecorator(codec));
      codec = new VectorCodecTextureResourceLevel1(true);
      protocol.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(TextureResource,true),false,1),codec);
      protocol.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(TextureResource,true),true,1),new OptionalCodecDecorator(codec));
      codec = new VectorCodecIGameObjectLevel1(false);
      protocol.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(IGameObject,false),false,1),codec);
      protocol.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(IGameObject,false),true,1),new OptionalCodecDecorator(codec));
      codec = new VectorCodecIGameObjectLevel1(true);
      protocol.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(IGameObject,true),false,1),codec);
      protocol.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(IGameObject,true),true,1),new OptionalCodecDecorator(codec));
      osgi.injectService(IClientLog,function(param1:Object):void {
        TLSEngine.clientLog = IClientLog(param1);
      },function():IClientLog {
        return TLSEngine.clientLog;
      });
      osgi.injectService(IClientLog,function(param1:Object):void {
        TLSSecurityParameters.clientLog = IClientLog(param1);
      },function():IClientLog {
        return TLSSecurityParameters.clientLog;
      });
      osgi.injectService(IClientLog,function(param1:Object):void {
        TLSSocket.clientLog = IClientLog(param1);
      },function():IClientLog {
        return TLSSocket.clientLog;
      });
      osgi.injectService(CommandService,function(param1:Object):void {
        CoreCommands.commandService = CommandService(param1);
      },function():CommandService {
        return CoreCommands.commandService;
      });
      osgi.injectService(GameTypeRegistry,function(param1:Object):void {
        CoreCommands.gameTypeRegistry = GameTypeRegistry(param1);
      },function():GameTypeRegistry {
        return CoreCommands.gameTypeRegistry;
      });
      osgi.injectService(ModelRegistry,function(param1:Object):void {
        CoreCommands.modelRegister = ModelRegistry(param1);
      },function():ModelRegistry {
        return CoreCommands.modelRegister;
      });
      osgi.injectService(ResourceRegistry,function(param1:Object):void {
        CoreCommands.resourceRegistry = ResourceRegistry(param1);
      },function():ResourceRegistry {
        return CoreCommands.resourceRegistry;
      });
      osgi.injectService(SpaceRegistry,function(param1:Object):void {
        CoreCommands.spaceRegistry = SpaceRegistry(param1);
      },function():SpaceRegistry {
        return CoreCommands.spaceRegistry;
      });
      osgi.injectService(ITransportService,function(param1:Object):void {
        CoreCommands.transportService = ITransportService(param1);
      },function():ITransportService {
        return CoreCommands.transportService;
      });
      osgi.injectService(LogService,function(param1:Object):void {
        UncaughtErrorServerLogImpl.loggerService = LogService(param1);
      },function():LogService {
        return UncaughtErrorServerLogImpl.loggerService;
      });
      osgi.injectService(INetworkService,function(param1:Object):void {
        OpenSpaceCommand.networkService = INetworkService(param1);
      },function():INetworkService {
        return OpenSpaceCommand.networkService;
      });
      osgi.injectService(SpaceRegistry,function(param1:Object):void {
        OpenSpaceCommand.spaceRegistry = SpaceRegistry(param1);
      },function():SpaceRegistry {
        return OpenSpaceCommand.spaceRegistry;
      });
      osgi.injectService(ITransportService,function(param1:Object):void {
        ControlConnectionSender.transportService = ITransportService(param1);
      },function():ITransportService {
        return ControlConnectionSender.transportService;
      });
      osgi.injectService(ILauncherParams,function(param1:Object):void {
        SocketConnection.launcherParams = ILauncherParams(param1);
      },function():ILauncherParams {
        return SocketConnection.launcherParams;
      });
      osgi.injectService(LogService,function(param1:Object):void {
        SocketConnection.logService = LogService(param1);
      },function():LogService {
        return SocketConnection.logService;
      });
      osgi.injectService(IErrorMessageService,function(param1:Object):void {
        SocketConnection.messageBoxService = IErrorMessageService(param1);
      },function():IErrorMessageService {
        return SocketConnection.messageBoxService;
      });
      osgi.injectService(INetworkService,function(param1:Object):void {
        SocketConnection.networkService = INetworkService(param1);
      },function():INetworkService {
        return SocketConnection.networkService;
      });
      osgi.injectService(AddressService,function(param1:Object):void {
        ControlCommandHandler.addressService = AddressService(param1);
      },function():AddressService {
        return ControlCommandHandler.addressService;
      });
      osgi.injectService(IDisplay,function(param1:Object):void {
        ControlCommandHandler.display = IDisplay(param1);
      },function():IDisplay {
        return ControlCommandHandler.display;
      });
      osgi.injectService(ILauncherParams,function(param1:Object):void {
        ControlCommandHandler.launcherParams = ILauncherParams(param1);
      },function():ILauncherParams {
        return ControlCommandHandler.launcherParams;
      });
      osgi.injectService(LogService,function(param1:Object):void {
        ControlCommandHandler.logService = LogService(param1);
      },function():LogService {
        return ControlCommandHandler.logService;
      });
      osgi.injectService(IErrorMessageService,function(param1:Object):void {
        ControlCommandHandler.messageBoxService = IErrorMessageService(param1);
      },function():IErrorMessageService {
        return ControlCommandHandler.messageBoxService;
      });
      osgi.injectService(SpaceRegistry,function(param1:Object):void {
        ControlCommandHandler.spaceRegistry = SpaceRegistry(param1);
      },function():SpaceRegistry {
        return ControlCommandHandler.spaceRegistry;
      });
      osgi.injectService(LogService,function(param1:Object):void {
        SpaceCommandHandler.logService = LogService(param1);
      },function():LogService {
        return SpaceCommandHandler.logService;
      });
      osgi.injectService(ModelRegistry,function(param1:Object):void {
        SpaceCommandHandler.modelRegistry = ModelRegistry(param1);
      },function():ModelRegistry {
        return SpaceCommandHandler.modelRegistry;
      });
      osgi.injectService(IProtocol,function(param1:Object):void {
        SpaceCommandHandler.protocol = IProtocol(param1);
      },function():IProtocol {
        return SpaceCommandHandler.protocol;
      });
      osgi.injectService(SpaceRegistry,function(param1:Object):void {
        SpaceCommandHandler.spaceRegistry = SpaceRegistry(param1);
      },function():SpaceRegistry {
        return SpaceCommandHandler.spaceRegistry;
      });
      osgi.injectService(ITransportService,function(param1:Object):void {
        SpaceCommandHandler.transportService = ITransportService(param1);
      },function():ITransportService {
        return SpaceCommandHandler.transportService;
      });
      osgi.injectService(LogService,function(param1:Object):void {
        ControlRootCodec.logService = LogService(param1);
      },function():LogService {
        return ControlRootCodec.logService;
      });
      osgi.injectService(SpaceRegistry,function(param1:Object):void {
        GameObjectCodec.spaceRegistry = SpaceRegistry(param1);
      },function():SpaceRegistry {
        return GameObjectCodec.spaceRegistry;
      });
      osgi.injectService(IProtocol,function(param1:Object):void {
        ModelsRegistryImpl.protocol = IProtocol(param1);
      },function():IProtocol {
        return ModelsRegistryImpl.protocol;
      });
      osgi.injectService(IResourceLoader,function(param1:Object):void {
        ResourceRegistryImpl.resourceLoader = IResourceLoader(param1);
      },function():IResourceLoader {
        return ResourceRegistryImpl.resourceLoader;
      });
      osgi.injectService(LogService,function(param1:Object):void {
        BatchResourceLoader.logService = LogService(param1);
      },function():LogService {
        return BatchResourceLoader.logService;
      });
      osgi.injectService(IErrorMessageService,function(param1:Object):void {
        BatchResourceLoader.messageBoxService = IErrorMessageService(param1);
      },function():IErrorMessageService {
        return BatchResourceLoader.messageBoxService;
      });
      osgi.injectService(IResourceLoader,function(param1:Object):void {
        BatchResourceLoader.resourceLoader = IResourceLoader(param1);
      },function():IResourceLoader {
        return BatchResourceLoader.resourceLoader;
      });
      osgi.injectService(ResourceRegistry,function(param1:Object):void {
        BatchResourceLoader.resourceRegistry = ResourceRegistry(param1);
      },function():ResourceRegistry {
        return BatchResourceLoader.resourceRegistry;
      });
      osgi.injectService(ILauncherParams,function(param1:Object):void {
        Resource.launcherParams = ILauncherParams(param1);
      },function():ILauncherParams {
        return Resource.launcherParams;
      });
      osgi.injectService(LogService,function(param1:Object):void {
        Resource.logService = LogService(param1);
      },function():LogService {
        return Resource.logService;
      });
      osgi.injectService(ResourceRegistry,function(param1:Object):void {
        Resource.resourceRegistry = ResourceRegistry(param1);
      },function():ResourceRegistry {
        return Resource.resourceRegistry;
      });
      osgi.injectService(IResourceTimer,function(param1:Object):void {
        Resource.resourceTimer = IResourceTimer(param1);
      },function():IResourceTimer {
        return Resource.resourceTimer;
      });
      osgi.injectService(IResourceLocalStorage,function(param1:Object):void {
        ResourceLoader.localStorage = IResourceLocalStorage(param1);
      },function():IResourceLocalStorage {
        return ResourceLoader.localStorage;
      });
      osgi.injectService(INetworkService,function(param1:Object):void {
        ResourceLoader.networkSerice = INetworkService(param1);
      },function():INetworkService {
        return ResourceLoader.networkSerice;
      });
      osgi.injectService(IResourceLocalStorage,function(param1:Object):void {
        ImageResource.resourceLocalStorage = IResourceLocalStorage(param1);
      },function():IResourceLocalStorage {
        return ImageResource.resourceLocalStorage;
      });
      osgi.injectService(ILocaleService,function(param1:Object):void {
        LocalizedImageResource.localeService = ILocaleService(param1);
      },function():ILocaleService {
        return LocalizedImageResource.localeService;
      });
      osgi.injectService(IResourceLocalStorage,function(param1:Object):void {
        MultiframeTextureResource.resourceLocalStorage = IResourceLocalStorage(param1);
      },function():IResourceLocalStorage {
        return MultiframeTextureResource.resourceLocalStorage;
      });
      osgi.injectService(IResourceLocalStorage,function(param1:Object):void {
        TextureResource.resourceLocalStorage = IResourceLocalStorage(param1);
      },function():IResourceLocalStorage {
        return TextureResource.resourceLocalStorage;
      });
      osgi.injectService(ILauncherParams,function(param1:Object):void {
        AddressServiceFakeImpl.launcherParams = ILauncherParams(param1);
      },function():ILauncherParams {
        return AddressServiceFakeImpl.launcherParams;
      });
      osgi.injectService(ModelRegistry,function(param1:Object):void {
        GameObject.modelRegistry = ModelRegistry(param1);
      },function():ModelRegistry {
        return GameObject.modelRegistry;
      });
      osgi.injectService(LogService,function(param1:Object):void {
        Space.logService = LogService(param1);
      },function():LogService {
        return Space.logService;
      });
      osgi.injectService(IErrorMessageService,function(param1:Object):void {
        Space.messageBoxService = IErrorMessageService(param1);
      },function():IErrorMessageService {
        return Space.messageBoxService;
      });
      osgi.injectService(INetworkService,function(param1:Object):void {
        Space.networkService = INetworkService(param1);
      },function():INetworkService {
        return Space.networkService;
      });
      osgi.injectService(ITransportService,function(param1:Object):void {
        Space.transportService = ITransportService(param1);
      },function():ITransportService {
        return Space.transportService;
      });
      modelRegisterAdapt = osgi.getService(ModelRegistry) as ModelRegistry;
      modelRegisterAdapt.registerAdapt(IObjectLoadListener,IObjectLoadListenerAdapt);
      modelRegisterAdapt.registerEvents(IObjectLoadListener,IObjectLoadListenerEvents);
      modelRegisterAdapt.registerAdapt(ObjectLoadListener,ObjectLoadListenerAdapt);
      modelRegisterAdapt.registerEvents(ObjectLoadListener,ObjectLoadListenerEvents);
      modelRegisterAdapt.registerAdapt(ObjectLoadPostListener,ObjectLoadPostListenerAdapt);
      modelRegisterAdapt.registerEvents(ObjectLoadPostListener,ObjectLoadPostListenerEvents);
      modelRegisterAdapt.registerAdapt(ObjectUnloadListener,ObjectUnloadListenerAdapt);
      modelRegisterAdapt.registerEvents(ObjectUnloadListener,ObjectUnloadListenerEvents);
      modelRegisterAdapt.registerAdapt(ObjectUnloadPostListener,ObjectUnloadPostListenerAdapt);
      modelRegisterAdapt.registerEvents(ObjectUnloadPostListener,ObjectUnloadPostListenerEvents);
    }

    public function stop(param1:OSGi) : void {
    }
  }
}
