import common from '@ohos.app.ability.common'
import Want from '@ohos.app.ability.Want'
import { Header } from '../components/Header'
@Entry
@Component
struct DocumentListPage {
  private  index:number=1
  @State docs: number[] = []

  private  context = getContext(this) as common.UIAbilityContext

  build() {
    Row() {
      Column({space:10}) {
        Header({title:'文档列表'})
        Divider()
        Button('新建文档')
          .onClick(()=>{
            //添加文档
            this.docs.push(this.index)
            //跳转到文档编辑的UIAbility

            //跳转目的地want
            let want: Want={
              deviceId:'', //为空指当前设备
              bundleName:'com.zj.demo', //在appScope中的app.json5中
              moduleName:'entry', //在当前项目的module.json5中
              abilityName:'DocumentAbility',
              parameters:{
                instanceKey:'idx_'+this.index++
              }
            }
            //跳转
            this.context.startAbility(want)
          })

        ForEach(this.docs,ind=>{
          Row({space:10}){
            Image($r('app.media.ic_files_doc'))
              .width(20)
            Text(`文档${ind}`)
              .fontSize(18)
              .onClick(()=>{
                //跳转到文档编辑的UIAbility

                //跳转目的地want
                let wants:Want={
                  deviceId:'',
                  bundleName:'com.zj.demo',
                  moduleName:'entry',
                  abilityName:'DocumentAbility',
                  parameters:{
                    instanceKey:'idx_'+ind
                  }
                }
                //跳转
                this.context.startAbility(wants)
              })
          }
          .width('100%')
        })


      }
      .width('100%')
      .height('100%')
      .padding(20)
    }

  }
}