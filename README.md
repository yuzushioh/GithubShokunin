# GithubShokunin

GithubShokunin is a slack bot that makes it easier for development teams to do peer-coding-reviews👍🏻

This can be used only for repositories in organization accounts.

## What GithubShokunin can do

It can do only one task currently but it will get smarter and more useful😉

### Currently Avalable

- Choose a reviewer from the team at random and request the code review from Slack by mentioning a bot like ⬇️

```
@Bot review #PR number
```

## 🚀 Vapor

You can install the vapor toolbox by running

```
curl -sL toolbox.vapor.sh | bash
```

make sure that the Toolbox was installed successfully by running

```
vapor --help
```

Then move to the work directory and by running the following command line, you can open up the project with Xcode!

```
vapor xcode
```


## Documentation

- [Vapor](https://vapor.github.io/documentation/)
- [Slack bot]( https://api.slack.com/bot-users)
- [Github Developer API Guide](https://developer.github.com/v3/)

## Setup

### 🔑 Slack Bot Config

Once you create a bot in slack configration, place its token and name in `Config/bot-config.json`.

When it is runing on your mac, the file should look like this!

```json
{
    "token": "xoxo-2h4j43n5g3i2mn24g",
    "bot_name": "GithubShokunin"
}
```

When you deploy, use environmental variables instead! so it should look like this.

```json
{
    "token": "$BOT_TOKEN",
    "bot_name": "$BOT_NAME"
}
```

### 🔑 Github Configration

First, create a team and add all reviewers to it, and get its id (which is a integer like 356125) 
Then in `Config/github-config.json`, place your 

- organization name(which is owner name)
- repository name, 
- review team id, 
- github token 

When it is runing on your mac, the file should look like this!

```json
{
    "owner_name": "yuzushioh",
    "repo_name": "GithubShokunin",
    "review_team_id": "12345",
    "github_token": "biub3h24vb53vjjv2v42v24g(sample)"
}
```

When you deploy, use environmental variables instead! so it should look like this.

```json
{
    "owner_name": "$GITHUB_OWNER_NAME",
    "repo_name": "$GITHUB_REPO_NAME",
    "review_team_id": "$GITHUB_REVIEW_TEAM_ID",
    "github_token": "$GITHUB_TOKEN"
}
```
