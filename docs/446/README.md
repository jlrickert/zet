# Mongo style filter example with typescript

Here is an example pulled straight from [Mongo git repo](https://github.com/mongodb/node-mongodb-native) itself found in the file**src/mongo_types.ts**. The only modification is the removal of the **bson** types and **WithId**.

```ts
export type Filter<TSchema> = {
  [P in keyof TSchema]?: Condition<TSchema[P]>;
} & RootFilterOperators<TSchema>;

export type Condition<T> =
  | AlternativeType<T>
  | FilterOperators<AlternativeType<T>>;

export type RegExpOrString<T> = T extends string ? RegExp | T : T;

export type AlternativeType<T> =
  T extends ReadonlyArray<infer U> ? T | RegExpOrString<U> : RegExpOrString<T>;

export type FilterOperators<TValue> = {
  // Comparison
  $eq?: TValue;
  $gt?: TValue;
  $gte?: TValue;
  $in?: ReadonlyArray<TValue>;
  $lt?: TValue;
  $lte?: TValue;
  $ne?: TValue;
  $nin?: ReadonlyArray<TValue>;
  // Logical
  $not?: TValue extends string
    ? FilterOperators<TValue> | RegExp
    : FilterOperators<TValue>;
  // Element
  /**
   * When `true`, `$exists` matches the documents that contain the field,
   * including documents where the field value is null.
   */
  $exists?: boolean;
  // Evaluation
  $expr?: Record<string, any>;
  $jsonSchema?: Record<string, any>;
  $mod?: TValue extends number ? [number, number] : never;
  $regex?: TValue extends string ? RegExp | string : never;
  $options?: TValue extends string ? string : never;
  // Geospatial
  $geoIntersects?: { $geometry: Document };
  $geoWithin?: Document;
  $near?: Document;
  $nearSphere?: Document;
  $maxDistance?: number;
  // Array
  $all?: ReadonlyArray<any>;
  $elemMatch?: Document;
  $size?: TValue extends ReadonlyArray<any> ? number : never;
  // Bitwise
  $bitsAllClear?: BitwiseFilter;
  $bitsAllSet?: BitwiseFilter;
  $bitsAnyClear?: BitwiseFilter;
  $bitsAnySet?: BitwiseFilter;
  $rand?: Record<string, never>;
};

export type RootFilterOperators<TSchema> = {
  $and?: Filter<TSchema>[];
  $nor?: Filter<TSchema>[];
  $or?: Filter<TSchema>[];
  $text?: {
    $search: string;
    $language?: string;
    $caseSensitive?: boolean;
    $diacriticSensitive?: boolean;
  };
  $where?: string | ((this: TSchema) => boolean);
  $comment?: string | Document;
};
```