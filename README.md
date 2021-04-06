# Chronical

*Simple Swift Logger*

## Examples

### Default Chronical
```swift
let chrono = Chronical(
    label: "com.example.chronical"
)

enum SomeError: Error { case abc }

chrono.log(level: .success("Success"))
chrono.log(level: .info("Info"))
chrono.log(level: .warning("Warning"))
chrono.log(level: .error("Error", SomeError.abc))
chrono.log(level: .fatal("Fatal", SomeError.abc))
```

```
4/5/21, 7:05:42 PM CDT [com.example.chronical] ✅: Success
4/5/21, 7:05:42 PM CDT [com.example.chronical] ℹ️: Info
4/5/21, 7:05:42 PM CDT [com.example.chronical] ⚠️: Warning
4/5/21, 7:05:42 PM CDT [com.example.chronical] ❗️: Error
{
    abc: The operation couldn’t be completed. (ChronicalTests.ChronicalTests.(unknown context at $107087918).(unknown context at $107087964).SomeError error 0.)
}

4/5/21, 7:05:42 PM CDT [com.example.chronical] 🚨: Fatal
{
    abc: The operation couldn’t be completed. (ChronicalTests.ChronicalTests.(unknown context at $107087918).(unknown context at $107087964).SomeError error 0.)
}
```
