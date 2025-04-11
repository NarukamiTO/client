package alternativa.engine3d.objects {
  import alternativa.engine3d.alternativa3d;
  import alternativa.engine3d.core.Camera3D;
  import alternativa.engine3d.core.Canvas;
  import alternativa.engine3d.core.Debug;
  import alternativa.engine3d.core.Face;
  import alternativa.engine3d.core.Object3D;
  import alternativa.engine3d.core.Vertex;
  import alternativa.engine3d.core.Wrapper;

  use namespace alternativa3d;

  public class Occluder extends Object3D {
    alternativa3d var faceList:Face;
    alternativa3d var edgeList:Edge;
    alternativa3d var vertexList:Vertex;

    public var minSize:Number = 0;

    public function Occluder() {
      super();
    }

    public function createForm(param1:Mesh, param2:Boolean = false) : void {
      this.destroyForm();
      if(!param2) {
        param1 = param1.clone() as Mesh;
      }
      this.alternativa3d::faceList = param1.alternativa3d::faceList;
      this.alternativa3d::vertexList = param1.alternativa3d::vertexList;
      param1.alternativa3d::faceList = null;
      param1.alternativa3d::vertexList = null;
      var local3:Vertex = this.alternativa3d::vertexList;
      while(local3 != null) {
        local3.alternativa3d::transformId = 0;
        local3.id = null;
        local3 = local3.alternativa3d::next;
      }
      var local4:Face = this.alternativa3d::faceList;
      while(local4 != null) {
        local4.id = null;
        local4 = local4.alternativa3d::next;
      }
      var local5:String = this.calculateEdges();
      if(local5 != null) {
        this.destroyForm();
        throw new ArgumentError(local5);
      }
      calculateBounds();
    }

    public function destroyForm() : void {
      this.alternativa3d::faceList = null;
      this.alternativa3d::edgeList = null;
      this.alternativa3d::vertexList = null;
    }

    override public function clone() : Object3D {
      var local1:Occluder = new Occluder();
      local1.clonePropertiesFrom(this);
      return local1;
    }

    override protected function clonePropertiesFrom(param1:Object3D) : void {
      var local3:Vertex = null;
      var local4:Face = null;
      var local5:Vertex = null;
      var local6:Face = null;
      var local7:Edge = null;
      var local9:Vertex = null;
      var local10:Face = null;
      var local11:Wrapper = null;
      var local12:Wrapper = null;
      var local13:Wrapper = null;
      var local14:Edge = null;
      super.clonePropertiesFrom(param1);
      var local2:Occluder = param1 as Occluder;
      this.minSize = local2.minSize;
      local3 = local2.alternativa3d::vertexList;
      while(local3 != null) {
        local9 = new Vertex();
        local9.x = local3.x;
        local9.y = local3.y;
        local9.z = local3.z;
        local9.u = local3.u;
        local9.v = local3.v;
        local9.normalX = local3.normalX;
        local9.normalY = local3.normalY;
        local9.normalZ = local3.normalZ;
        local3.alternativa3d::value = local9;
        if(local5 != null) {
          local5.alternativa3d::next = local9;
        } else {
          this.alternativa3d::vertexList = local9;
        }
        local5 = local9;
        local3 = local3.alternativa3d::next;
      }
      local4 = local2.alternativa3d::faceList;
      while(local4 != null) {
        local10 = new Face();
        local10.material = local4.material;
        local10.alternativa3d::normalX = local4.alternativa3d::normalX;
        local10.alternativa3d::normalY = local4.alternativa3d::normalY;
        local10.alternativa3d::normalZ = local4.alternativa3d::normalZ;
        local10.alternativa3d::offset = local4.alternativa3d::offset;
        local4.alternativa3d::processNext = local10;
        local11 = null;
        local12 = local4.alternativa3d::wrapper;
        while(local12 != null) {
          local13 = new Wrapper();
          local13.alternativa3d::vertex = local12.alternativa3d::vertex.alternativa3d::value;
          if(local11 != null) {
            local11.alternativa3d::next = local13;
          } else {
            local10.alternativa3d::wrapper = local13;
          }
          local11 = local13;
          local12 = local12.alternativa3d::next;
        }
        if(local6 != null) {
          local6.alternativa3d::next = local10;
        } else {
          this.alternativa3d::faceList = local10;
        }
        local6 = local10;
        local4 = local4.alternativa3d::next;
      }
      var local8:Edge = local2.alternativa3d::edgeList;
      while(local8 != null) {
        local14 = new Edge();
        local14.a = local8.a.alternativa3d::value;
        local14.b = local8.b.alternativa3d::value;
        local14.left = local8.left.alternativa3d::processNext;
        local14.right = local8.right.alternativa3d::processNext;
        if(local7 != null) {
          local7.next = local14;
        } else {
          this.alternativa3d::edgeList = local14;
        }
        local7 = local14;
        local8 = local8.next;
      }
      local3 = local2.alternativa3d::vertexList;
      while(local3 != null) {
        local3.alternativa3d::value = null;
        local3 = local3.alternativa3d::next;
      }
      local4 = local2.alternativa3d::faceList;
      while(local4 != null) {
        local4.alternativa3d::processNext = null;
        local4 = local4.alternativa3d::next;
      }
    }

    private function calculateEdges() : String {
      var local1:Face = null;
      var local2:Wrapper = null;
      var local3:Edge = null;
      var local4:Vertex = null;
      var local5:Vertex = null;
      var local6:Number = NaN;
      var local7:Number = NaN;
      var local8:Number = NaN;
      var local9:Number = NaN;
      var local10:Number = NaN;
      var local11:Number = NaN;
      local1 = this.alternativa3d::faceList;
      while(local1 != null) {
        local1.alternativa3d::calculateBestSequenceAndNormal();
        local2 = local1.alternativa3d::wrapper;
        while(local2 != null) {
          local4 = local2.alternativa3d::vertex;
          local5 = local2.alternativa3d::next != null ? local2.alternativa3d::next.alternativa3d::vertex : local1.alternativa3d::wrapper.alternativa3d::vertex;
          local3 = this.alternativa3d::edgeList;
          while(local3 != null) {
            if(local3.a == local4 && local3.b == local5) {
              return "The supplied geometry is not valid.";
            }
            if(local3.a == local5 && local3.b == local4) {
              break;
            }
            local3 = local3.next;
          }
          if(local3 != null) {
            local3.right = local1;
          } else {
            local3 = new Edge();
            local3.a = local4;
            local3.b = local5;
            local3.left = local1;
            local3.next = this.alternativa3d::edgeList;
            this.alternativa3d::edgeList = local3;
          }
          local2 = local2.alternativa3d::next;
          local4 = local5;
        }
        local1 = local1.alternativa3d::next;
      }
      local3 = this.alternativa3d::edgeList;
      while(local3 != null) {
        if(local3.left == null || local3.right == null) {
          return "The supplied geometry is non whole.";
        }
        local6 = local3.b.x - local3.a.x;
        local7 = local3.b.y - local3.a.y;
        local8 = local3.b.z - local3.a.z;
        local9 = local3.right.alternativa3d::normalZ * local3.left.alternativa3d::normalY - local3.right.alternativa3d::normalY * local3.left.alternativa3d::normalZ;
        local10 = local3.right.alternativa3d::normalX * local3.left.alternativa3d::normalZ - local3.right.alternativa3d::normalZ * local3.left.alternativa3d::normalX;
        local11 = local3.right.alternativa3d::normalY * local3.left.alternativa3d::normalX - local3.right.alternativa3d::normalX * local3.left.alternativa3d::normalY;
        if(local6 * local9 + local7 * local10 + local8 * local11 < 0) {
        }
        local3 = local3.next;
      }
      return null;
    }

    override alternativa3d function draw(param1:Camera3D, param2:Canvas) : void {
      var local3:Canvas = null;
      var local4:int = 0;
      var local7:Vertex = null;
      var local12:Vertex = null;
      var local13:Vertex = null;
      var local14:Number = NaN;
      var local15:Number = NaN;
      var local16:Number = NaN;
      var local17:Number = NaN;
      var local18:Number = NaN;
      var local19:Number = NaN;
      var local20:Number = NaN;
      var local22:Vertex = null;
      var local23:Vertex = null;
      var local24:Number = NaN;
      if(this.alternativa3d::faceList == null || this.alternativa3d::edgeList == null) {
        return;
      }
      alternativa3d::calculateInverseMatrix();
      var local5:Boolean = true;
      var local6:Face = this.alternativa3d::faceList;
      while(local6 != null) {
        if(local6.alternativa3d::normalX * alternativa3d::imd + local6.alternativa3d::normalY * alternativa3d::imh + local6.alternativa3d::normalZ * alternativa3d::iml > local6.alternativa3d::offset) {
          local6.alternativa3d::distance = 1;
          local5 = false;
        } else {
          local6.alternativa3d::distance = 0;
        }
        local6 = local6.alternativa3d::next;
      }
      if(local5) {
        return;
      }
      var local8:int = 0;
      var local9:Boolean = true;
      var local10:Number = Number(param1.alternativa3d::viewSizeX);
      var local11:Number = Number(param1.alternativa3d::viewSizeY);
      var local21:Edge = this.alternativa3d::edgeList;
      for(; local21 != null; local21 = local21.next) {
        if(local21.left.alternativa3d::distance != local21.right.alternativa3d::distance) {
          if(local21.left.alternativa3d::distance > 0) {
            local12 = local21.a;
            local13 = local21.b;
          } else {
            local12 = local21.b;
            local13 = local21.a;
          }
          local14 = alternativa3d::ma * local12.x + alternativa3d::mb * local12.y + alternativa3d::mc * local12.z + alternativa3d::md;
          local15 = alternativa3d::me * local12.x + alternativa3d::mf * local12.y + alternativa3d::mg * local12.z + alternativa3d::mh;
          local16 = alternativa3d::mi * local12.x + alternativa3d::mj * local12.y + alternativa3d::mk * local12.z + alternativa3d::ml;
          local17 = alternativa3d::ma * local13.x + alternativa3d::mb * local13.y + alternativa3d::mc * local13.z + alternativa3d::md;
          local18 = alternativa3d::me * local13.x + alternativa3d::mf * local13.y + alternativa3d::mg * local13.z + alternativa3d::mh;
          local19 = alternativa3d::mi * local13.x + alternativa3d::mj * local13.y + alternativa3d::mk * local13.z + alternativa3d::ml;
          if(alternativa3d::culling > 0) {
            if(local16 <= -local14 && local19 <= -local17) {
              if(local9 && local18 * local14 - local17 * local15 > 0) {
                local9 = false;
              }
              continue;
            }
            if(local19 > -local17 && local16 <= -local14) {
              local20 = (local14 + local16) / (local14 + local16 - local17 - local19);
              local14 += (local17 - local14) * local20;
              local15 += (local18 - local15) * local20;
              local16 += (local19 - local16) * local20;
            } else if(local19 <= -local17 && local16 > -local14) {
              local20 = (local14 + local16) / (local14 + local16 - local17 - local19);
              local17 = local14 + (local17 - local14) * local20;
              local18 = local15 + (local18 - local15) * local20;
              local19 = local16 + (local19 - local16) * local20;
            }
            if(local16 <= local14 && local19 <= local17) {
              if(local9 && local18 * local14 - local17 * local15 > 0) {
                local9 = false;
              }
              continue;
            }
            if(local19 > local17 && local16 <= local14) {
              local20 = (local16 - local14) / (local16 - local14 + local17 - local19);
              local14 += (local17 - local14) * local20;
              local15 += (local18 - local15) * local20;
              local16 += (local19 - local16) * local20;
            } else if(local19 <= local17 && local16 > local14) {
              local20 = (local16 - local14) / (local16 - local14 + local17 - local19);
              local17 = local14 + (local17 - local14) * local20;
              local18 = local15 + (local18 - local15) * local20;
              local19 = local16 + (local19 - local16) * local20;
            }
            if(local16 <= -local15 && local19 <= -local18) {
              if(local9 && local18 * local14 - local17 * local15 > 0) {
                local9 = false;
              }
              continue;
            }
            if(local19 > -local18 && local16 <= -local15) {
              local20 = (local15 + local16) / (local15 + local16 - local18 - local19);
              local14 += (local17 - local14) * local20;
              local15 += (local18 - local15) * local20;
              local16 += (local19 - local16) * local20;
            } else if(local19 <= -local18 && local16 > -local15) {
              local20 = (local15 + local16) / (local15 + local16 - local18 - local19);
              local17 = local14 + (local17 - local14) * local20;
              local18 = local15 + (local18 - local15) * local20;
              local19 = local16 + (local19 - local16) * local20;
            }
            if(local16 <= local15 && local19 <= local18) {
              if(local9 && local18 * local14 - local17 * local15 > 0) {
                local9 = false;
              }
              continue;
            }
            if(local19 > local18 && local16 <= local15) {
              local20 = (local16 - local15) / (local16 - local15 + local18 - local19);
              local14 += (local17 - local14) * local20;
              local15 += (local18 - local15) * local20;
              local16 += (local19 - local16) * local20;
            } else if(local19 <= local18 && local16 > local15) {
              local20 = (local16 - local15) / (local16 - local15 + local18 - local19);
              local17 = local14 + (local17 - local14) * local20;
              local18 = local15 + (local18 - local15) * local20;
              local19 = local16 + (local19 - local16) * local20;
            }
            local9 = false;
          }
          local12 = local12.alternativa3d::create();
          local12.alternativa3d::next = local7;
          local8++;
          local7 = local12;
          local7.alternativa3d::cameraX = local19 * local15 - local18 * local16;
          local7.alternativa3d::cameraY = local17 * local16 - local19 * local14;
          local7.alternativa3d::cameraZ = local18 * local14 - local17 * local15;
          local7.x = local14;
          local7.y = local15;
          local7.z = local16;
          local7.u = local17;
          local7.v = local18;
          local7.alternativa3d::offset = local19;
        }
      }
      if(local7 != null) {
        if(this.minSize > 0) {
          local22 = Vertex.alternativa3d::createList(local8);
          local12 = local7;
          local13 = local22;
          while(local12 != null) {
            local13.x = local12.x * local10 / local12.z;
            local13.y = local12.y * local11 / local12.z;
            local13.u = local12.u * local10 / local12.alternativa3d::offset;
            local13.v = local12.v * local11 / local12.alternativa3d::offset;
            local13.alternativa3d::cameraX = local13.y - local13.v;
            local13.alternativa3d::cameraY = local13.u - local13.x;
            local13.alternativa3d::offset = local13.alternativa3d::cameraX * local13.x + local13.alternativa3d::cameraY * local13.y;
            local12 = local12.alternativa3d::next;
            local13 = local13.alternativa3d::next;
          }
          if(alternativa3d::culling > 0) {
            if(Boolean(alternativa3d::culling & 4)) {
              local14 = -param1.alternativa3d::viewSizeX;
              local15 = -param1.alternativa3d::viewSizeY;
              local17 = -param1.alternativa3d::viewSizeX;
              local18 = Number(param1.alternativa3d::viewSizeY);
              local12 = local22;
              while(local12 != null) {
                local16 = local14 * local12.alternativa3d::cameraX + local15 * local12.alternativa3d::cameraY - local12.alternativa3d::offset;
                local19 = local17 * local12.alternativa3d::cameraX + local18 * local12.alternativa3d::cameraY - local12.alternativa3d::offset;
                if(!(local16 < 0 || local19 < 0)) {
                  break;
                }
                if(local16 >= 0 && local19 < 0) {
                  local20 = local16 / (local16 - local19);
                  local14 += (local17 - local14) * local20;
                  local15 += (local18 - local15) * local20;
                } else if(local16 < 0 && local19 >= 0) {
                  local20 = local16 / (local16 - local19);
                  local17 = local14 + (local17 - local14) * local20;
                  local18 = local15 + (local18 - local15) * local20;
                }
                local12 = local12.alternativa3d::next;
              }
              if(local12 == null) {
                local13 = local7.alternativa3d::create();
                local13.alternativa3d::next = local23;
                local23 = local13;
                local23.x = local14;
                local23.y = local15;
                local23.u = local17;
                local23.v = local18;
              }
            }
            if(Boolean(alternativa3d::culling & 8)) {
              local14 = Number(param1.alternativa3d::viewSizeX);
              local15 = Number(param1.alternativa3d::viewSizeY);
              local17 = Number(param1.alternativa3d::viewSizeX);
              local18 = -param1.alternativa3d::viewSizeY;
              local12 = local22;
              while(local12 != null) {
                local16 = local14 * local12.alternativa3d::cameraX + local15 * local12.alternativa3d::cameraY - local12.alternativa3d::offset;
                local19 = local17 * local12.alternativa3d::cameraX + local18 * local12.alternativa3d::cameraY - local12.alternativa3d::offset;
                if(!(local16 < 0 || local19 < 0)) {
                  break;
                }
                if(local16 >= 0 && local19 < 0) {
                  local20 = local16 / (local16 - local19);
                  local14 += (local17 - local14) * local20;
                  local15 += (local18 - local15) * local20;
                } else if(local16 < 0 && local19 >= 0) {
                  local20 = local16 / (local16 - local19);
                  local17 = local14 + (local17 - local14) * local20;
                  local18 = local15 + (local18 - local15) * local20;
                }
                local12 = local12.alternativa3d::next;
              }
              if(local12 == null) {
                local13 = local7.alternativa3d::create();
                local13.alternativa3d::next = local23;
                local23 = local13;
                local23.x = local14;
                local23.y = local15;
                local23.u = local17;
                local23.v = local18;
              }
            }
            if(Boolean(alternativa3d::culling & 0x10)) {
              local14 = Number(param1.alternativa3d::viewSizeX);
              local15 = -param1.alternativa3d::viewSizeY;
              local17 = -param1.alternativa3d::viewSizeX;
              local18 = -param1.alternativa3d::viewSizeY;
              local12 = local22;
              while(local12 != null) {
                local16 = local14 * local12.alternativa3d::cameraX + local15 * local12.alternativa3d::cameraY - local12.alternativa3d::offset;
                local19 = local17 * local12.alternativa3d::cameraX + local18 * local12.alternativa3d::cameraY - local12.alternativa3d::offset;
                if(!(local16 < 0 || local19 < 0)) {
                  break;
                }
                if(local16 >= 0 && local19 < 0) {
                  local20 = local16 / (local16 - local19);
                  local14 += (local17 - local14) * local20;
                  local15 += (local18 - local15) * local20;
                } else if(local16 < 0 && local19 >= 0) {
                  local20 = local16 / (local16 - local19);
                  local17 = local14 + (local17 - local14) * local20;
                  local18 = local15 + (local18 - local15) * local20;
                }
                local12 = local12.alternativa3d::next;
              }
              if(local12 == null) {
                local13 = local7.alternativa3d::create();
                local13.alternativa3d::next = local23;
                local23 = local13;
                local23.x = local14;
                local23.y = local15;
                local23.u = local17;
                local23.v = local18;
              }
            }
            if(Boolean(alternativa3d::culling & 0x20)) {
              local14 = -param1.alternativa3d::viewSizeX;
              local15 = Number(param1.alternativa3d::viewSizeY);
              local17 = Number(param1.alternativa3d::viewSizeX);
              local18 = Number(param1.alternativa3d::viewSizeY);
              local12 = local22;
              while(local12 != null) {
                local16 = local14 * local12.alternativa3d::cameraX + local15 * local12.alternativa3d::cameraY - local12.alternativa3d::offset;
                local19 = local17 * local12.alternativa3d::cameraX + local18 * local12.alternativa3d::cameraY - local12.alternativa3d::offset;
                if(!(local16 < 0 || local19 < 0)) {
                  break;
                }
                if(local16 >= 0 && local19 < 0) {
                  local20 = local16 / (local16 - local19);
                  local14 += (local17 - local14) * local20;
                  local15 += (local18 - local15) * local20;
                } else if(local16 < 0 && local19 >= 0) {
                  local20 = local16 / (local16 - local19);
                  local17 = local14 + (local17 - local14) * local20;
                  local18 = local15 + (local18 - local15) * local20;
                }
                local12 = local12.alternativa3d::next;
              }
              if(local12 == null) {
                local13 = local7.alternativa3d::create();
                local13.alternativa3d::next = local23;
                local23 = local13;
                local23.x = local14;
                local23.y = local15;
                local23.u = local17;
                local23.v = local18;
              }
            }
          }
          local24 = 0;
          local16 = local22.x;
          local19 = local22.y;
          local12 = local22;
          while(local12.alternativa3d::next != null) {
            local12 = local12.alternativa3d::next;
          }
          local12.alternativa3d::next = local23;
          local12 = local22;
          while(local12 != null) {
            local24 += (local12.u - local16) * (local12.y - local19) - (local12.v - local19) * (local12.x - local16);
            if(local12.alternativa3d::next == null) {
              break;
            }
            local12 = local12.alternativa3d::next;
          }
          local12.alternativa3d::next = Vertex.alternativa3d::collector;
          Vertex.alternativa3d::collector = local22;
          if(local24 / (param1.alternativa3d::viewSizeX * param1.alternativa3d::viewSizeY * 8) < this.minSize) {
            local12 = local7;
            while(local12.alternativa3d::next != null) {
              local12 = local12.alternativa3d::next;
            }
            local12.alternativa3d::next = Vertex.alternativa3d::collector;
            Vertex.alternativa3d::collector = local7;
            return;
          }
        }
        if(param1.debug && (local4 = int(param1.alternativa3d::checkInDebug(this))) > 0) {
          local3 = param2.alternativa3d::getChildCanvas(true,false);
          if(Boolean(local4 & Debug.EDGES)) {
            local12 = local7;
            while(local12 != null) {
              local14 = local12.x * local10 / local12.z;
              local15 = local12.y * local11 / local12.z;
              local17 = local12.u * local10 / local12.alternativa3d::offset;
              local18 = local12.v * local11 / local12.alternativa3d::offset;
              local3.alternativa3d::gfx.moveTo(local14,local15);
              local3.alternativa3d::gfx.lineStyle(3,255);
              local3.alternativa3d::gfx.lineTo(local14 + (local17 - local14) * 0.8,local15 + (local18 - local15) * 0.8);
              local3.alternativa3d::gfx.lineStyle(3,16711680);
              local3.alternativa3d::gfx.lineTo(local17,local18);
              local12 = local12.alternativa3d::next;
            }
          }
          if(Boolean(local4 & Debug.BOUNDS)) {
            Debug.alternativa3d::drawBounds(param1,local3,this,boundMinX,boundMinY,boundMinZ,boundMaxX,boundMaxY,boundMaxZ);
          }
        }
        param1.alternativa3d::occluders[param1.alternativa3d::numOccluders] = local7;
        ++param1.alternativa3d::numOccluders;
      } else if(local9) {
        if(param1.debug && (local4 = int(param1.alternativa3d::checkInDebug(this))) > 0) {
          local3 = param2.alternativa3d::getChildCanvas(true,false);
          if(Boolean(local4 & Debug.EDGES)) {
            local20 = 1.5;
            local3.alternativa3d::gfx.moveTo(-local10 + local20,-local11 + local20);
            local3.alternativa3d::gfx.lineStyle(3,255);
            local3.alternativa3d::gfx.lineTo(-local10 + local20,local11 * 0.6);
            local3.alternativa3d::gfx.lineStyle(3,16711680);
            local3.alternativa3d::gfx.lineTo(-local10 + local20,local11 - local20);
            local3.alternativa3d::gfx.lineStyle(3,255);
            local3.alternativa3d::gfx.lineTo(local10 * 0.6,local11 - local20);
            local3.alternativa3d::gfx.lineStyle(3,16711680);
            local3.alternativa3d::gfx.lineTo(local10 - local20,local11 - local20);
            local3.alternativa3d::gfx.lineStyle(3,255);
            local3.alternativa3d::gfx.lineTo(local10 - local20,-local11 * 0.6);
            local3.alternativa3d::gfx.lineStyle(3,16711680);
            local3.alternativa3d::gfx.lineTo(local10 - local20,-local11 + local20);
            local3.alternativa3d::gfx.lineStyle(3,255);
            local3.alternativa3d::gfx.lineTo(-local10 * 0.6,-local11 + local20);
            local3.alternativa3d::gfx.lineStyle(3,16711680);
            local3.alternativa3d::gfx.lineTo(-local10 + local20,-local11 + local20);
          }
          if(Boolean(local4 & Debug.BOUNDS)) {
            Debug.alternativa3d::drawBounds(param1,local3,this,boundMinX,boundMinY,boundMinZ,boundMaxX,boundMaxY,boundMaxZ);
          }
        }
        param1.alternativa3d::clearOccluders();
        param1.alternativa3d::occludedAll = true;
      }
    }

    override alternativa3d function updateBounds(param1:Object3D, param2:Object3D = null) : void {
      var local3:Vertex = this.alternativa3d::vertexList;
      while(local3 != null) {
        if(param2 != null) {
          local3.alternativa3d::cameraX = param2.alternativa3d::ma * local3.x + param2.alternativa3d::mb * local3.y + param2.alternativa3d::mc * local3.z + param2.alternativa3d::md;
          local3.alternativa3d::cameraY = param2.alternativa3d::me * local3.x + param2.alternativa3d::mf * local3.y + param2.alternativa3d::mg * local3.z + param2.alternativa3d::mh;
          local3.alternativa3d::cameraZ = param2.alternativa3d::mi * local3.x + param2.alternativa3d::mj * local3.y + param2.alternativa3d::mk * local3.z + param2.alternativa3d::ml;
        } else {
          local3.alternativa3d::cameraX = local3.x;
          local3.alternativa3d::cameraY = local3.y;
          local3.alternativa3d::cameraZ = local3.z;
        }
        if(local3.alternativa3d::cameraX < param1.boundMinX) {
          param1.boundMinX = local3.alternativa3d::cameraX;
        }
        if(local3.alternativa3d::cameraX > param1.boundMaxX) {
          param1.boundMaxX = local3.alternativa3d::cameraX;
        }
        if(local3.alternativa3d::cameraY < param1.boundMinY) {
          param1.boundMinY = local3.alternativa3d::cameraY;
        }
        if(local3.alternativa3d::cameraY > param1.boundMaxY) {
          param1.boundMaxY = local3.alternativa3d::cameraY;
        }
        if(local3.alternativa3d::cameraZ < param1.boundMinZ) {
          param1.boundMinZ = local3.alternativa3d::cameraZ;
        }
        if(local3.alternativa3d::cameraZ > param1.boundMaxZ) {
          param1.boundMaxZ = local3.alternativa3d::cameraZ;
        }
        local3 = local3.alternativa3d::next;
      }
    }
  }
}

import alternativa.engine3d.core.Face;
import alternativa.engine3d.core.Vertex;
class Edge {
  public var next:Edge;
  public var a:Vertex;
  public var b:Vertex;
  public var left:Face;
  public var right:Face;

  public function Edge() {
    super();
  }
}
