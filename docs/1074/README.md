# Trick: Enforce interface implementation in GO

An example would be `var _ = (SomeInterface)((*SomeStruct)(nil))`