import TaskModel from '../model/TaskModel'
import Tasks from '../viewmodel/Tasks'
/*@Observed
class Tasks{
  static id:number=1
  name:string =`任务${Tasks.id++}`
  finished:boolean=false
}*/

@Styles function taskCard(){
  .width('95%')
  .padding(20)
  .backgroundColor(Color.White)
  .borderRadius(15)
  .shadow({radius:6,color:'#1F000000',offsetX:2,offsetY:4})
}

@Extend(Text) function finishTask(){
  .decoration({type:TextDecorationType.LineThrough})
  .fontColor('#B1B2B1')
}

@Component
export struct TaskItem{

  @ObjectLink t:Tasks
  onTaskChange:()=>void

  build(){
    Row(){
      if(this.t.finished){
        Text(this.t.name)
          .fontSize(20)
          .finishTask()
      }else{
        Text(this.t.name)
          .fontSize(20)
      }

      Checkbox()
        .select(this.t.finished)
        .onChange(v=>{
          //this.t.finished=v
          TaskModel.updateTaskStatus(this.t.id,v)
            .then(()=>{
              console.log('testTag','处理完成任务：',this.t.name)
              this.t.finished=v
              this.onTaskChange()
            })
            .catch(err=>{
              console.log('testTag','处理完成任务失败：',this.t.name)
            })

        })
    }
    .taskCard()
    .justifyContent(FlexAlign.SpaceBetween)
  }
}