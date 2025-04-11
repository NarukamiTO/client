package projects.tanks.clients.fp10.libraries.tanksservices.service.blockuser {
  import flash.net.SharedObject;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.storage.IStorageService;
  import projects.tanks.clients.fp10.libraries.tanksservices.utils.UidUtil;

  public class BlockUserService implements IBlockUserService {
    [Inject]
    public static var storageService:IStorageService;

    private static var so:SharedObject;

    public function BlockUserService() {
      super();
    }

    public function getBlockList() : Array {
      var local1:Array = null;
      so = storageService.getStorage();
      local1 = so.data.blocklist;
      if(local1 == null) {
        local1 = new Array();
      }
      return local1;
    }

    public function blockUser(param1:String) : void {
      var local2:Array = null;
      var local3:String = UidUtil.userNameWithoutClanTag(param1);
      so = storageService.getStorage();
      local2 = so.data.blocklist;
      if(local2 == null) {
        local2 = new Array();
      }
      var local4:int = int(local2.indexOf(local3));
      if(local4 > -1) {
        local2.splice(local4,1);
      }
      local2.push(local3);
      so.data.blocklist = local2;
    }

    public function unblockUser(param1:String) : void {
      var local2:Array = null;
      so = storageService.getStorage();
      local2 = so.data.blocklist;
      if(local2 == null) {
        local2 = new Array();
      }
      var local3:int = int(local2.indexOf(UidUtil.userNameWithoutClanTag(param1)));
      if(local3 > -1) {
        local2.splice(local3,1);
      }
      so.data.blocklist = local2;
    }

    public function unblockAll() : void {
      so = storageService.getStorage();
      so.data.blocklist = new Array();
    }

    public function isBlocked(param1:String) : Boolean {
      var local2:Array = null;
      var local3:int = 0;
      so = storageService.getStorage();
      local2 = so.data.blocklist;
      if(local2 == null) {
        local2 = new Array();
        so.data.blocklist = local2;
      }
      local3 = int(local2.indexOf(UidUtil.userNameWithoutClanTag(param1)));
      return local3 > -1;
    }
  }
}
