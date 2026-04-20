#include "ChooseStatusNormalList.h"

#include "Components/TextBlock.h"
#include "Components/UniformGridPanel.h"

void UChooseStatusNormalList::InitInfo(const FText& InTitle, TArray<FNormalListInfo> InResult)
{
    Title->SetText(InTitle);
    Item_Panel->ClearChildren();

    const int32 DataCount = InResult.Num();
    int32 TotalTargetCount = DataCount;

    if (DataCount > 0 && TotalTargetCount != 0)
    {
        TotalTargetCount = FMath::DivideAndRoundUp(DataCount, 2);
    }

    for (int32 Index = 0; Index < TotalTargetCount; ++Index)
    {
        UChooseStatusBtnBase* NewButton = CreateWidget<UChooseStatusBtnBase>(this, ButtonClass);
        if (!NewButton)
        {
            continue;
        }

        NewButton->InitInfo(InResult[Index].Icon, InResult[Index].Result);
    }
}
