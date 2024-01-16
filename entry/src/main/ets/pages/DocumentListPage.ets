import { Header } from '../components/Header'
@Entry
@Component
struct DocumentListPage {
  private  index:number=1
  @State docs: number[] = []

  build() {
    Row() {
      Column({space:10}) {
        Header({title:'文档列表'})
        Divider()
        Button('新建文档')
          .onClick(()=>{
            //添加文档
            this.docs.push(this.index++)
            //跳转到文档编辑的UIAbility

          })

        ForEach(this.docs,ind=>{
          Row({space:10}){
            Image($r('app.media.ic_files_doc'))
              .width(20)
            Text(`文档${ind}`)
              .fontSize(18)
              .onClick(()=>{
                //跳转到文档编辑的UIAbility
              })
          }
          .width('100%')
        })


      }
      .width('100%')
    }
    .height('100%')
  }
}