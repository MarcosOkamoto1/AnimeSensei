# AnimeSensei

AnimeSensei is an iOS app built with SwiftUI that helps users discover anime based on what they feel like watching.

Users can describe their preferences in natural language, such as:

> “I want a short and emotional fantasy anime.”

The app uses real data from the AniList GraphQL API to display anime covers, genres, episode counts, scores, and descriptions.

## Features

* SwiftUI interface
* Search, results, and detail screens
* AniList API integration
* Remote image loading with `AsyncImage`
* Loading and error states
* Reusable anime cards
* Mock data for testing

## Technologies

* Swift
* SwiftUI
* URLSession
* Codable
* GraphQL
* AniList API

## Project Structure

```text
AnimeSensei
├── Models
├── Views
├── Services
├── MockData
└── AnimeSenseiApp.swift
```

## Status

The app can currently fetch anime from AniList, display remote cover images, and navigate to a detail screen.

The next step is connecting the user's search text to the API before adding the AI recommendation layer.

## Author

Developed by Marcos Vinicius Alencar de Souza Okamoto as a portfolio project focused on SwiftUI, API integration, and artificial intelligence.
