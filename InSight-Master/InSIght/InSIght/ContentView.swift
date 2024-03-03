import SwiftUI
import Speech

struct DentButtonStyle: ButtonStyle {
  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .padding()
      .background(
        RoundedRectangle(cornerRadius: 5)
          .fill(configuration.isPressed ? Color.gray.opacity(0.5) : Color.clear)
      )
  }
}

struct GradientBackground: View {
  @Binding var colors: [Color]

  var body: some View {
    LinearGradient(gradient: Gradient(colors: colors), startPoint: .top, endPoint: .bottom)
      .edgesIgnoringSafeArea(.all)
      .onAppear {
        withAnimation(Animation.linear(duration: 5.0).repeatForever(autoreverses: true)) {
          self.randomizeGradient()
        }
      }
  }

  func randomizeGradient() {
    colors = [
        Color(
          red: .random(in: 0...1),
          green: .random(in: 0...1),
          blue: .random(in: 0...1)
        ),
        Color(
          red: .random(in: 0...1),
          green: .random(in: 0...1),
          blue: .random(in: 0...1))]
  }
   
}

struct ContentView: View {
    @State private var gradientColors: [Color] = [Color.purple, Color.indigo]
    @State private var isSignUpButtonVisible = true
    @State private var username = ""
    @State private var password = ""
    
    var body: some View {
        NavigationView {
            ZStack {
                GradientBackground(colors: $gradientColors)
                
                VStack {
                    
                    VStack {
                        Text("Study.")
                            .font(.title)
                            .foregroundColor(.white)
                            .padding(.bottom, -5)
                        Text("More Efficiently")
                            .font(.title)
                            .foregroundColor(.white)
                            .padding(.bottom, 20)
                    }
                    
                    
                    
                    TextField("Username", text: $username)
                        .padding()
                        .background(Color.white.opacity(0.0))
                        .cornerRadius(5.0)
                        .padding(.bottom, 20)
                        .onChange(of: username) { newValue in
                            withAnimation {
                                isSignUpButtonVisible = newValue.isEmpty && password.isEmpty
                            }
                        }
                    
                    SecureField("Password", text: $password)
                        .padding()
                        .background(Color.white.opacity(0.0))
                        .cornerRadius(5.0)
                        .padding(.bottom, 20)
                        .onChange(of: password) { newValue in
                            withAnimation {
                                isSignUpButtonVisible = newValue.isEmpty && username.isEmpty
                            }
                        }
                    
                    if isSignUpButtonVisible {
                        HStack(spacing: 20) {
                            Link(destination: URL(string: "https://accounts.google.com")!) {
                                Image("google_icon")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 30, height: 30)
                            }
                            .buttonStyle(DentButtonStyle())
                            
                            Link(destination: URL(string: "https://icloud.com")!) {
                                Image("apple_icon")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 30, height: 30)
                            }

                            .buttonStyle(DentButtonStyle())
                            
                            Link(destination: URL(string: "https://facebook.com/login")!) {
                                Image("facebook_icon")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 30, height: 30)
                            }
                            .buttonStyle(DentButtonStyle())
                        }
                        .padding(.bottom, 20)
                    }
                    
                    // Login Button
                    NavigationLink(destination: DestPage().background(GradientBackground(colors: $gradientColors))) {
                        Text("Login")
                            .foregroundColor(.white)
                    }
                    .buttonStyle(DentButtonStyle())
                    .padding(.bottom, 10)
                    
                    // Sign Up Button
                    NavigationLink(destination: SignUpPage().background(GradientBackground(colors: $gradientColors))) {
                        Text("Sign Up")
                            .foregroundColor(.white)
                    }
                    .buttonStyle(DentButtonStyle())
                    .opacity(isSignUpButtonVisible ? 1.0 : 0.0) // Hide or show the "Sign Up" button
                    .padding(.horizontal, 50)
                }
                .navigationTitle("")
                .navigationBarHidden(true)
            }
        }
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
    
    
    struct GooglePage: View {
        var body: some View {
            Text("Google Page Content Goes Here")
                .foregroundColor(.white)
                .padding()
        }
    }
    
    struct ApplePage: View {
        var body: some View {
            Text("Apple Page Content Goes Here")
                .foregroundColor(.white)
                .padding()
        }
    }
    
    struct FacebookPage: View {
        var body: some View {
            Text("Facebook Page Content Goes Here")
                .foregroundColor(.white)
                .padding()
        }
    }
    
    
    struct DestPage: View {
        @State private var gradientColors: [Color] = [Color.purple, Color.indigo]
        @State private var isCalendarVisible = false
        @State private var scrollOffset: CGFloat = 0.0
        
        var body: some View {
            NavigationView {
                ZStack {
                    // Gradient Background
                    GradientBackground(colors: $gradientColors)
                    
                    // Content
                    GeometryReader { geometry in
                        VStack {
                            // Profile Picture and Home
                            HStack {
                                HStack {
                                    // Profile Icon on the left as a button
                                    NavigationLink(destination: SetPage().background(GradientBackground(colors: $gradientColors))) {
                                        Image("pfp")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 70, height: 70)
                                            .opacity(isCalendarVisible ? 0.0 : 1.0)
                                            .clipShape(Circle())
                                            .overlay(
                                                Circle()
                                                    .stroke(Color.clear, lineWidth: 1)
                                            )
                                            .padding([.top, .leading], 10)
                                    }
                                    
                                    Spacer()
                                    
                                    // Home Text centered
                                    Text("Home")
                                        .font(.title)
                                        .foregroundColor(.white)
                                        .opacity(isCalendarVisible ? 0.0 : 1.0)
                                    
                                    Spacer()
                                    
                                    // Plus Button on the right
                                    NavigationLink(destination: MenuPage().background(GradientBackground(colors: $gradientColors))) {
                                        Image(systemName: "plus.circle.fill")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 70, height: 70)
                                            .foregroundColor(.white)
                                            .opacity(isCalendarVisible ? 0.0 : 1.0)
                                            .background(
                                                Circle()
                                                    .fill(Color.clear) // You can customize the background color
                                            )
                                            .overlay(
                                                Circle()
                                                    .stroke(Color.clear, lineWidth: 1)
                                            )
                                            .padding([.top, .trailing], 10)
                                    }
                                    .padding(.top, 20)
                                }
                                .padding(.top, 20) // Adjust top padding
                            }
                            
                            // Schedule Section
                            ZStack(alignment: .top) { // Ensure vertical alignment
                                // White Glass Part (Adjusted opacity for better visibility)
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(Color.white.opacity(0.8)) // Adjust opacity for better readability
                                    .frame(height: geometry.size.height)
                                    .offset(y: max(0, min(isCalendarVisible ? scrollOffset : 0, geometry.size.height * 3 / 4))) // Constrain scroll within 3/4 height
                                    .mask(
                                        RoundedRectangle(cornerRadius: 20)
                                            .offset(y: max(0, min(isCalendarVisible ? scrollOffset : 0, geometry.size.height * 3 / 4))) // Constrain mask within 3/4 height
                                    )
                                    .blur(radius: isCalendarVisible ? 0 : 0) // Adjust blur radius
                                
                                VStack {
                                    // Pull-Down Button (Pill Shape)
                                    Capsule()
                                        .fill(Color.white)
                                        .frame(width: 50, height: 5)
                                        .padding(.top, 10)
                                        .opacity(isCalendarVisible ? 0.0 : 1.0)
                                        .overlay(
                                            Capsule()
                                                .fill(Color.white)
                                                .frame(width: 30, height: 5)
                                                .padding(.top, 10)
                                                .onTapGesture {
                                                    withAnimation {
                                                        isCalendarVisible.toggle()
                                                        // Toggle visibility and adjust scrollOffset to 3/4 height
                                                        scrollOffset = isCalendarVisible ? geometry.size.height * 3 / 4 : 0
                                                    }
                                                }
                                        )
                                    
                                    // Calendar Content with Schedule
                                    if isCalendarVisible {
                                        VStack(spacing: 10) {
                                            // Add schedule content here
                                            
                                            // Example schedule content
                                            Image("cal")
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: 349, height: 229) // Adjust the size as needed

                                            Spacer() // Add Spacer to push the following views to the bottom
                                            
                                            // Plus Button at the Bottom
                                            Button(action: {
                                                // Add action for the plus button at the bottom
                                            }) {
                                            }
                                            .buttonStyle(DentButtonStyle())
                                        }
                                        .padding()
                                    } else {
                                        VStack(alignment: .leading, spacing: 10) {
                                            // Today's Schedule in a bigger Menlo font
                                            Text("Today's Schedule")
                                                .font(Font.custom("Menlo", size: 40))
                                                .foregroundColor(.black)
                                                .padding(.bottom, 10)
                                            
                                            Text("1. 3 - 4 Physics: Laws of Motion")
                                            Text("2. 4 - 4.10: Break")
                                            Text("3. 4.10 - 5 Chemistry: Periodic Table")
                                            Text("4. 5 - 5.15: Break")
                                            Text("5. 5.15 - 6 Maths: Rational Numbers")
                                            Text("6. 6 - 7: Break")
                                            Text("7. 7 - 8 Biology: Skeletal System")
                                            Text("8. 8 - 8.30: Dinner")
                                            Text("9. 8.30 - 9.30 History: Age of Guptas")
                                            // ... (add remaining schedule items)
                                        }
                                        .padding()
                                    }
                                    
                                    Spacer()
                                }
                                .padding(.top, 20) // Adjust padding for content spacing
                            } // End ZStack(alignment)
                            .gesture(
                                DragGesture().onChanged { value in
                                    // Constrain scroll within 0 to 3/4 of screen height
                                    scrollOffset = max(0, min(value.translation.height + scrollOffset, geometry.size.height * 3 / 4))
                                }
                                .onEnded { value in
                                    // Snap scrollOffset to closest position (0 or 3/4 height)
                                    withAnimation {
                                        scrollOffset = scrollOffset > geometry.size.height / 2 ? geometry.size.height * 3 / 4 : 0
                                        isCalendarVisible = scrollOffset > 0
                                    }
                                }
                            )
                        }
                    }
                }
                .ignoresSafeArea()
            }
        }
    }

    
    struct SignUpPage: View {
        @State private var gradientColors: [Color] = [Color.purple, Color.indigo]
        @State private var email = ""
        @State private var name = ""
        @State private var phoneNumber = ""
        @State private var password = ""
        @State private var reEnterPassword = ""
        @State private var selectedCurriculum = "CBSE"
        
        var body: some View {
            NavigationView {
                ZStack {
                    GradientBackground(colors: $gradientColors)
                    
                    VStack {
                        Text("Sign Up")
                            .font(.title)
                            .foregroundColor(.white)
                            .padding(.top, 50)
                        
                        TextField("Email", text: $email)
                            .padding()
                            .background(Color.white.opacity(0.3))
                            .cornerRadius(5.0)
                            .padding(.bottom, 20)
                        
                        TextField("Name", text: $name)
                            .padding()
                            .background(Color.white.opacity(0.3))
                            .cornerRadius(5.0)
                            .padding(.bottom, 20)
                        
                        TextField("Phone Number", text: $phoneNumber)
                            .padding()
                            .background(Color.white.opacity(0.3))
                            .cornerRadius(5.0)
                            .padding(.bottom, 20)
                        
                        SecureField("Password", text: $password)
                            .padding()
                            .background(Color.white.opacity(0.3))
                            .cornerRadius(5.0)
                            .padding(.bottom, 20)
                        
                        SecureField("Re-enter Password", text: $reEnterPassword)
                            .padding()
                            .background(Color.white.opacity(0.3))
                            .cornerRadius(5.0)
                            .padding(.bottom, 20)
                        
                        // Dropdown for School Curriculum
                        Picker("Select Curriculum", selection: $selectedCurriculum) {
                            Text("CBSE").tag("CBSE")
                            Text("ICSE").tag("ICSE")
                        }
                        .padding()
                        .background(Color.white.opacity(0.3))
                        .cornerRadius(5.0)
                        .pickerStyle(MenuPickerStyle())
                        .padding(.bottom, 20)
                        
                        // Login Button
                        NavigationLink(destination: DestPage().background(GradientBackground(colors: $gradientColors))) {
                            Text("Create Account")
                                .foregroundColor(.white)
                        }
                        .buttonStyle(DentButtonStyle())
                        .padding(.bottom, 10)
                        
                    }
                    .padding(.horizontal, 50)
                }
                .navigationTitle("")
                .navigationBarHidden(true)
            }
            
                 }
             }
    }

struct SetPage: View {
var body: some View {
    Text("Facebook Page Content Goes Here")
        .foregroundColor(.white)
        .padding()
}
}
    
struct MenuPage: View {
    @State private var gradientColors: [Color] = [Color.purple, Color.indigo]

    var body: some View {
        NavigationView {
            ZStack {
                // Gradient Background
                GradientBackground(colors: $gradientColors)

                VStack(spacing: 30) {
                    NavigationLink(destination: MemPage().background(GradientBackground(colors: $gradientColors))) {
                        Image(systemName: "mic.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 70, height: 70)
                            .foregroundColor(.white)
                            .background(
                                Circle()
                                    .fill(Color.clear) // You can customize the background color
                            )
                            .overlay(
                                Circle()
                                    .stroke(Color.clear, lineWidth: 1)
                            )
                            .padding([.top, .trailing], 10)
                            .padding(.top, 20)
                    }

                    Link(destination: URL(string: "https://chat.openai.com")!) {
                        Image(systemName: "message.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 70, height: 70)
                            .foregroundColor(.white)
                            .background(
                                Circle()
                                    .fill(Color.clear) // You can customize the background color
                            )
                            .overlay(
                                Circle()
                                    .stroke(Color.clear, lineWidth: 1)
                            )
                            .padding([.top, .trailing], 10)
                            .padding(.top, 20)
                    }

                    NavigationLink(destination: StatPage()) {
                        Image(systemName: "chart.bar.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 70, height: 70)
                            .foregroundColor(.white)
                            .background(
                                Circle()
                                    .fill(Color.clear) // You can customize the background color
                            )
                            .overlay(
                                Circle()
                                    .stroke(Color.clear, lineWidth: 1)
                            )
                            .padding([.top, .trailing], 10)
                            .padding(.top, 20)
                    }
                }
                .padding()
            }
            .navigationTitle("Menu")
            .navigationBarHidden(true)
            .ignoresSafeArea()
        }
    }
}

    
    
    
    struct MenuPage_Previews: PreviewProvider {
        static var previews: some View {
            MenuPage()
        }
    }
    

    
    struct StatPage: View {
        let data: [Double] = [6, 9, 4, 8]
        let maxValue: Double = 10 // Adjust this based on your data range
        
        var body: some View {
            VStack {
                Text("Statistics")
                    .font(.title)
                    .foregroundColor(.white)
                    .padding()
                
                HStack(spacing: 10) {
                    ForEach(data, id: \.self) { value in
                        BarView(value: value, maxValue: maxValue)
                    }
                }
                .padding()
            }
            .background(LinearGradient(gradient: Gradient(colors: [Color.purple, Color.indigo]), startPoint: .top, endPoint: .bottom))
            .navigationBarTitle("Stat Page", displayMode: .inline)
        }
    }
    
    struct BarView: View {
        let value: Double
        let maxValue: Double
        
        var body: some View {
            VStack {
                ZStack(alignment: .bottom) {
                    Capsule()
                        .fill(Color.gray.opacity(0.3))
                        .frame(width: 30, height: 150)
                    
                    Capsule()
                        .fill(Color.clear)
                        .frame(width: 30, height: getHeight())
                }
                
                Text("\(Int(value))")
                    .foregroundColor(.white)
                    .padding(.top, 5)
            }
        }
        
        func getHeight() -> CGFloat {
            let percentage = CGFloat(value / maxValue)
            return 150 * percentage
        }
    }
    
    struct StatPage_Previews: PreviewProvider {
        static var previews: some View {
            StatPage()
        }
    }

struct MemPage: View {
    @State private var isRecording = false
    @State private var recordedText = ""
    @State private var audioEngine: AVAudioEngine?
    @State private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    @State private var recognitionTask: SFSpeechRecognitionTask?

    var body: some View {
        VStack {
            if isRecording {
                Text("Recording...")
                    .foregroundColor(.red)
            } else {
                Text("Tap to Record")
                    .foregroundColor(.white)
            }

            Button(action: {
                isRecording.toggle()
                if isRecording {
                    startRecording()
                } else {
                    stopRecording()
                }
            }) {
                Image(systemName: isRecording ? "stop.circle.fill" : "mic.circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
                    .foregroundColor(.white)
            }

            Text("Recorded Text:")
                .foregroundColor(.white)

            Text(recordedText)
                .foregroundColor(.white)
        }
        .onAppear {
            requestSpeechAuthorization()
        }
        .background(Color.clear) // You can customize the background color
        .ignoresSafeArea()
    }

    private func requestSpeechAuthorization() {
        SFSpeechRecognizer.requestAuthorization { authStatus in
            // Handle the authorization status
        }
    }

    private func startRecording() {
        audioEngine = AVAudioEngine()
        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()

        guard let recognitionRequest = recognitionRequest else { return }

        recognitionRequest.shouldReportPartialResults = true

        recognitionTask = speechRecognizer.recognitionTask(with: recognitionRequest) { result, error in
            guard let result = result else {
                if let error = error {
                    print("Recognition task error: \(error)")
                }
                return
            }

            self.recordedText = result.bestTranscription.formattedString
        }

        let audioSession = AVAudioSession.sharedInstance()

        do {
            try audioSession.setCategory(.record, mode: .measurement, options: .duckOthers)
            try audioSession.setActive(true, options: .notifyOthersOnDeactivation)

            let inputNode = audioEngine!.inputNode
            let recordingFormat = inputNode.outputFormat(forBus: 0)

            inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { buffer, _ in
                recognitionRequest.append(buffer)
            }

            audioEngine!.prepare()

            try audioEngine!.start()
        } catch {
            print("Error starting recording: \(error)")
        }
    }

    private func stopRecording() {
        audioEngine?.stop()
        audioEngine?.inputNode.removeTap(onBus: 0)
        recognitionRequest?.endAudio()
        recognitionTask?.cancel()
    }

    private var speechRecognizer: SFSpeechRecognizer {
        let recognizer = SFSpeechRecognizer(locale: Locale.current)
        return recognizer!
    }
}
