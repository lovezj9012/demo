import AbilityStage from '@ohos.app.ability.AbilityStage';
import Want from '@ohos.app.ability.Want';

export default class MyAbilityStage extends  AbilityStage{

  onAcceptWant(want:Want):string{
    if(want.abilityName==='DocumentAbility'){
      return `DocAbilityInstace_${want.parameters.instanceKey}`
    }
    return ''
  }
}