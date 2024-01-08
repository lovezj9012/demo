
@Observed
class Tasks{
  static id:number=1
  name:string =`任务${Tasks.id++}`
  finished:boolean=false
}

class StateTask{
  totalTask:number=0
  finishTask:number=0
}

import {TaskItem} from '../components/TaskItem'

@Component
export struct TaskList{
  //属性
  //@Link finishTask: number
  //@Link totalTask: number
  //类
  @Link stateTask:StateTask ;
  @State tasks:Tasks []=[]
  HandTaskChange(){
    this.stateTask.totalTask=this.tasks.length
    this.stateTask.finishTask=this.tasks.filter(t=>t.finished).length
  }

  build(){
    Column(){
      Button('新增任务')
        .width(200)
        .onClick(()=>{
          this.tasks.push(new Tasks())
          this.HandTaskChange()
        })
        .margin({bottom:20,top:10})

      List({space:10}){
        ForEach(this.tasks,(t:Tasks,index)=>{
          ListItem(){

            TaskItem({t:t,onTaskChange:this.HandTaskChange.bind(this)})
          }
          .swipeAction({end:this.DeleteButton(index)})

        })
      }
      .width('100%')
      .alignListItem(ListItemAlign.Center)
      //.layoutWeight(1)
    }
  }

  @Builder DeleteButton(index:number){
    Button(){
      Image($r('app.media.ic_public_delete_filled'))
        .width(20)
        .fillColor(Color.White)
    }
    .width(40)
    .height(40)
    .margin({left:6})
    .type(ButtonType.Circle)
    .backgroundColor(Color.Red)
    .onClick(()=>{
      this.tasks.splice(index,1)
      this.HandTaskChange()
    })
  }
}