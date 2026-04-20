#pragma once

#include "CoreMinimal.h"
#include "Components/TextBlock.h"
#include "Components/UniformGridPanel.h"

class UTextBlock;

USTRUCT(BlueprintType)
struct FNormalListInfo
{
    GENERATED_BODY()

    UPROPERTY(EditDefaultsOnly, BlueprintReadOnly, Category = "UI", meta = (ClampMin = "0"))
    TSoftObjectPtr<UTexture2D> Icon;

    UPROPERTY(EditDefaultsOnly, BlueprintReadOnly, Category = "UI")
    TArray<FText> Result;
};

UCLASS(Blueprintable)
class MYGAME_API UChooseStatusNormalList : public UUserWidget
{
    GENERATED_BODY()

public:
    void InitInfo(const FText& InTitle, TArray<FNormalListInfo> InResult);

protected:
    UPROPERTY(BlueprintReadOnly, meta = (BindWidget))
    TObjectPtr<UTextBlock> Title;

    UPROPERTY(BlueprintReadOnly, meta = (BindWidget))
    TObjectPtr<UUniformGridPanel> Item_Panel;
};
