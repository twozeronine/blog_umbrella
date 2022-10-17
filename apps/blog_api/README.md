# BlogApi

```
user_path  GET     /api/users              BlogApi.UserController :index
user_path  GET     /api/users/:id/edit     BlogApi.UserController :edit
user_path  GET     /api/users/:id          BlogApi.UserController :show
user_path  POST    /api/users              BlogApi.UserController :create
user_path  PATCH   /api/users/:id          BlogApi.UserController :update
           PUT     /api/users/:id          BlogApi.UserController :update
user_path  DELETE  /api/users/:id          BlogApi.UserController :delete
```
