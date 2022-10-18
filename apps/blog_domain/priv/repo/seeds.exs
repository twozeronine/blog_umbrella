# alias BlogDomain.Repo
# alias BlogDomain.Accounts.User
alias BlogDomain.Accounts
# alias BlogDomain.Boards
# alias BlogDomain.Boards.Comment
# alias BlogDomain.Boards.Post

%{
  user_email: "example@example.com",
  user_name: "example",
  password: "supersecret",
  posts: [
    %{
      title: "post2",
      description: "description",
      comments: [
        %{
          user_id: 1,
          description: "comment_description1"
        },
        %{
          user_id: 1,
          description: "comment_description2"
        },
        %{
          user_id: 1,
          description: "comment_description3"
        }
      ]
    },
    %{
      title: "post2",
      description: "description3",
      comments: [
        %{
          user_id: 1,
          description: "p2-comment_description4"
        },
        %{
          user_id: 1,
          description: "p2-comment_description5"
        },
        %{
          user_id: 1,
          description: "p2-comment_description6"
        }
      ]
    }
  ]
}
|> Accounts.create_user()

%{
  user_email: "devil@jocker.com",
  user_name: "annie",
  password: "supersecret",
  posts: [
    %{
      title: "post3",
      description: "description",
      comments: [
        %{
          user_id: 2,
          description: "comment_description1"
        },
        %{
          user_id: 2,
          description: "comment_description2"
        },
        %{
          user_id: 2,
          description: "comment_description3"
        }
      ]
    },
    %{
      title: "post4",
      description: "description3",
      comments: [
        %{
          user_id: 2,
          description: "p2-comment_description4"
        },
        %{
          user_id: 2,
          description: "p2-comment_description5"
        },
        %{
          user_id: 2,
          description: "p2-comment_description6"
        }
      ]
    }
  ]
}
|> Accounts.create_user()
