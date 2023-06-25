# fccode-frontend

## How to generate GraphQL.swift files

1. Go to this folder

```
cd <your path to fccode-frontend>/GraphQL
```

2. Add new query or mutation

   - Create a new file called `<your new query/mutation>.graphql` or add new queries inside `xxx.graphql`

3. Run appollo-ios

```
./apollo-ios-cli generate
```

New files will show up in `/GraphQLAPI/Sources/Operations`
