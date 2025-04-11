package projects.tanks.client.clans.space.createclan {
  public interface IClanCreateModelBase {
    function alreadyInClan() : void;
    function correctName() : void;
    function correctTag() : void;
    function nameIsIncorrect() : void;
    function notUniqueName() : void;
    function notUniqueTag() : void;
    function otherError() : void;
    function tagIsIncorrect() : void;
  }
}
