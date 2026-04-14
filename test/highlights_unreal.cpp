DECLARE_DYNAMIC_MULTICAST_DELEGATE_OneParam(FOnHealthChanged, int32, NewHealth);

UENUM(BlueprintType)
enum class EActorState : uint8
{
    Idle UMETA(DisplayName = "Idle"),
    Attacking UMETA(DisplayName = "Attacking"),
    Dead UMETA(DisplayName = "Dead"),
};

USTRUCT(BlueprintType)
struct FActorStats
{
    GENERATED_BODY()

    UPROPERTY(EditAnywhere, BlueprintReadWrite, Category = "Stats", meta = (ClampMin = "0", ClampMax = "999"))
    int32 Health;

    UPROPERTY(EditAnywhere, BlueprintReadWrite, Category = "Stats", meta = (ClampMin = "0"))
    int32 Mana;
};

UCLASS(Blueprintable, meta = (DisplayName = "My Actor", ShortTooltip = "Parser coverage sample"))
class MY_API AMyActor : public AActor
{
    GENERATED_BODY()

public:
    UPROPERTY(EditAnywhere, BlueprintReadOnly, Category = "Stats", meta = (AllowPrivateAccess = "true"))
    int32 Health;

    UPROPERTY(VisibleAnywhere, BlueprintReadOnly, Category = "State")
    EActorState CurrentState;

    UPROPERTY(EditAnywhere, BlueprintReadWrite, Category = "Data")
    FActorStats Stats;

    UFUNCTION(BlueprintCallable, Category = "Combat", meta = (DisplayName = "Apply Damage"))
    void ApplyDamage(int32 InDamage);

    UFUNCTION(BlueprintPure, Category = "State")
    int32 GetHealth() const;
};
