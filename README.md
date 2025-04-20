# 🚨 RescueNow

**RescueNow** is a mobile application designed to revolutionize emergency response following road accidents. Leveraging smartphone sensors and real-time data sharing, the app ensures timely assistance even when victims are unable to call for help.

## 📱 Overview

RescueNow automatically detects severe vehicle impacts using the device’s accelerometer and GPS data. If the user doesn’t respond within a short window, the app immediately sends an alert to emergency services with the precise location of the accident.

This system ensures that:
- Accidents are reported even if victims are unconscious or unable to act
- EMS, police, and hospitals receive accurate, real-time information
- Victims are directed to the most suitable hospital based on emergency capacity and specialization

## 🔍 Key Features

- **Automatic Crash Detection**  
  Detects sudden impacts using built-in sensors like accelerometer and GPS.

- **Emergency Auto-Alert**  
  Sends alerts to emergency contacts and services if no user response is detected.

- **Real-time Location Sharing**  
  Shares precise coordinates with EMS, police, and hospitals.

- **Hospital Intelligence System**  
  Integrates hospital data (proximity, trauma care availability, capacity).

- **First Responder Coordination**  
  Streamlines communication between rescue teams and medical personnel.

- **User-Friendly Interface**  
  Clean, responsive UI designed for ease of use under stressful situations.

## 🧠 Technologies Used

- **Frontend**: Flutter / React Native *(choose whichever you’re using)*
- **Backend**: AWS Lambda, API Gateway
- **Database**: DynamoDB
- **Storage**: AWS S3
- **Auth**: AWS Cognito *(if used)*
- **Other Tools**: Git, GitHub, Android Studio / Xcode

## 🚀 How It Works

1. Detects crash using device sensors.
2. Displays a countdown timer asking if the user is okay.
3. If no response, sends automatic alert with GPS location.
4. Notifies emergency services and nearest equipped hospital.
5. Provides real-time coordination info for faster dispatch.

## 📦 Installation

```bash
git clone https://github.com/VESIT-CMPN-Projects/2024-25-TE29.git
cd RescueNow
# Follow mobile framework setup instructions (Flutter/React Native)
