import AVFoundation
import PlaygroundSupport
import UIKit

struct StorySlidesViewModel {
    let headerText: [String]
    let imageString: [String]
    let messageText: [String]
    let starImage: String
    let launchScreenViewHeaderText: String
    let instructionText: String

    init() {
        self.headerText = ["A story about us…",
                           "In the beginning…",
                           "‘Andela’ derives from Mandela",
                           "The Funding",
                           "Andela is competitive",
                           "Talented People",
                           "The Hackathon",
                           "Amazing Andelans",
                           "The Visit",
                           "Empowerment for Leadership",
                           "Partnership",
                           "Gender Inclusiveness",
                           "Positive Impact",
                           "I am Andelan",
                           "#TIA == Wakanda"]

        self.imageString = ["BlackPanther", "Beginning", "Mandela", "Funding", "Competition", "Idea", "Hackathon", "AmazingPeople", "Visit", "Empowerment", "Partnership", "WomenInTech", "Impact", "Samuel", "Andela"]

        self.instructionText = "Do you want to embark on the tour?\n\nIf so, click on the button below."

        self.launchScreenViewHeaderText = "You are about to watch the story of great minds in Africa who are passionate about changing the world through technology."

        self.messageText = ["It’s not just a movie. It’s a movement. It’s a story about a people whose voice has been faint. A people endowed with great technical skills. It is Wakanda: Andela is transforming the virtual Wakanda into reality. Andela is preparing and repositioning future tech leaders.",
                            "Andela was founded in 2014 to build a network of tech leaders in Africa and bridge the gap between U.S. and African tech sectors.",
                            "“Across the world brilliance is evenly distributed but opportunity is not.”\n\n—Jeremy Johnson, Andela CEO",
                            "Andela raised $24 million from Mark Zuckerberg’s and Priscilla Chan’s Fund to train African engineers.",
                            "Andela is a competitive four-year paid technical leadership program that invests in top software talent and pairs them with global tech companies.",
                            "”There’s extraordinary untapped talent out there. We just need to remove the barriers to help talented young people launch careers without debt and without leaving home.”\n\n—Christina Sass, Andela President",
                            "Andela team winning the Saucecode 2018 Hackathon competition, thereby gaining admission tickets to Facebook’s F8 Developer Conference 2108 in California, USA. Andelans are pacesetters.",
                            "Andelans are amazing people with a great culture and drive to change the world through technology.",
                            "Mark Zuckerberg came to Lagos, Nigeria, in part to meet Andela, a startup backed by the Chan Zuckerberg Initiative. He was warmly welcomed by Andelans who were thrilled to have him in the office.",
                            "Andela bridges skill gaps and empowers youths for leadership.",
                            "Google Africa is currently partnered with Andela and Udacity to provide 15,000 scholarships to developers in Africa as a way of giving back to the developer ecosystem.",
                            "In celebration of International Women’s Day, Andela hosted the Andela Women In Tech Summit. This reinforces Andela’s commitment to diversity and inclusion in the tech ecosystem. Andela is committed to attracting and developing female talent.",
                            "Andela developers are adding value and making positive impact with Andela’s business partners.",
                            "I hope to achieve great things with Swift. I love challenging tasks and I produce results. I love learning new things. I have a great interest in security and cryptography. I am exploring and I love sharing what I have learned with the community.",
                            "This Is Andela. The Wakanda of Africa.\n\nThe future belongs to us."]

        self.starImage = "Star"
    }

}


public class StorySlides : UIViewController {

    var backgroundSound: AVAudioPlayer?
    var currentIndex = 0
    var currentSlide: ScreenView?
    var screenTimer: Timer?
    var viewModel: StorySlidesViewModel!

    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        launchScreenView()
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.9651797414, green: 0.6645704508, blue: 0.358951211, alpha: 1)
        viewModel = StorySlidesViewModel()
    }

    func makeScreenView(index: Int) -> ScreenView? {
        let headerText = viewModel.headerText[index]
        let imageString = viewModel.imageString[index]
        let messageText = viewModel.messageText[index]
        let starImageString = viewModel.starImage

        guard
            let image = UIImage(named: imageString),
            let star = UIImage(named: starImageString)
            else { return nil }

        return ScreenView(frame: CGRect(x: view.frame.origin.x,
                                        y: view.frame.origin.y,
                                        width: view.frame.width - 20,
                                        height: view.frame.size.height - 120),
                          headerText: headerText,
                          message: messageText,
                          screenImage: image,
                          starImage: star,
                          starCount: index + 1)
    }

    func presentFirstSlide() {
        currentIndex = 0
        currentSlide = nil

        guard
            let slide = makeScreenView(index: currentIndex)
            else { return }

        presentSlide(slide)
    }

    func presentNextSlide() {
        currentIndex += 1

        if currentIndex <= (viewModel.messageText.count - 1) {
            guard
                let slide = makeScreenView(index: currentIndex)
                else { return }

            presentSlide(slide)
        } else {
            screenTimer?.invalidate()
        }
    }

    func presentSlide(_ slide: ScreenView) {
        let animations: [(ScreenView) -> Void] = [presentSlideFromRight,
                                                  presentSlideCurlUp,
                                                  presentSlideCrossDissolve,
                                                  presentSlideFromTop,
                                                  presentSlideFromBottom]
        let index = Int(arc4random_uniform(UInt32(animations.count)))

        animations[index](slide)
    }

    func presentSlideFromRight(_ slide: ScreenView) {
        slide.transform = CGAffineTransform(translationX: view.frame.width, y: 0)

        view.addSubview(slide)

        UIView.animate(withDuration: 0.75,
                       animations: { slide.transform = .identity },
                       completion: { _ in
                        slide.startAnimating()
                        self.currentSlide?.removeFromSuperview()

                        self.currentSlide = slide
        })
    }

    func presentSlideFromBottom(_ slide: ScreenView) {
        slide.transform = CGAffineTransform(translationX: 0,
                                            y: view.frame.height)

        view.addSubview(slide)

        UIView.animate(withDuration: 0.75,
                       animations: { slide.transform = .identity },
                       completion: { _ in
                        slide.startAnimating()

                        self.currentSlide?.removeFromSuperview()

                        self.currentSlide = slide
        })
    }

    func presentSlideFromTop(_ slide: ScreenView) {
        slide.transform = CGAffineTransform(translationX: 0,
                                            y: -view.frame.height)

        view.addSubview(slide)

        UIView.animate(withDuration: 0.75,
                       animations: { slide.transform = .identity },
                       completion: { _ in
                        slide.startAnimating()
                        self.currentSlide?.removeFromSuperview()

                        self.currentSlide = slide
        })
    }

    func presentSlideCurlUp(_ slide: ScreenView) {
        guard
            let current = currentSlide
            else { presentSlideFromRight(slide); return }

        UIView.transition(from: current,
                          to: slide,
                          duration: 0.75,
                          options: .transitionCurlUp) { _ in
                            slide.startAnimating()
                            self.currentSlide = slide
        }
    }

    func presentSlideCrossDissolve(_ slide: ScreenView) {
        guard
            let current = currentSlide
            else { presentSlideFromRight(slide); return }

        UIView.transition(from: current,
                          to: slide,
                          duration: 0.75,
                          options: .transitionCrossDissolve) { _ in
                            slide.startAnimating()


                            self.currentSlide = slide
        }
    }

    func launchScreenView() {

        let launchScreen = LaunchScreenView(frame: CGRect(x: view.frame.origin.x,
                                                          y: view.frame.origin.y,
                                                          width: view.frame.width, height: view.frame.height), launchContent: viewModel.launchScreenViewHeaderText, instructionText: viewModel.instructionText, starString: viewModel.starImage)

        let pulse = CASpringAnimation(keyPath: "transform.scale")
        
        pulse.autoreverses = true
        pulse.damping = 1.0
        pulse.duration = 0.6
        pulse.fromValue = 0.95
        pulse.initialVelocity = 0.5
        pulse.repeatCount = Float.infinity
        pulse.toValue = 1.0

        let tourButton = UIButton()

        tourButton.backgroundColor = UIColor.darkGray
        tourButton.frame = CGRect(x: 150,
                                  y: 460,
                                  width: 70,
                                  height: 30)

        tourButton.layer.cornerRadius = 5
        tourButton.layer.add(pulse, forKey: nil)
        tourButton.setTitle("Click me", for: .normal)
        tourButton.titleEdgeInsets = UIEdgeInsetsMake(10,10,15,10)
        tourButton.titleLabel?.adjustsFontSizeToFitWidth = true

        tourButton.addTarget(self, action: #selector(StorySlides.tourButtonPressed), for: .touchUpInside)

        launchScreen.tag = 10
        tourButton.tag = 12

        view.addSubview(launchScreen)
        view.addSubview(tourButton)
    }

    @objc
    func tourButtonPressed() {
        if let launchScreenViewViewWithTag = view.viewWithTag(10),
            let tourButtonViewWithTag = view.viewWithTag(12) {
            launchScreenViewViewWithTag.removeFromSuperview()
            tourButtonViewWithTag.removeFromSuperview()
        }

        presentFirstSlide()
        playAudio()
        screenTimer = Timer.scheduledTimer(withTimeInterval: 9,
                                           repeats: true) { [weak self] _ in
                                            self?.presentNextSlide()
                                            self?.drawReplayButton()
                                            self?.stopAudio()
        }
    }

    func playAudio() {
        guard let path = Bundle.main.path(forResource: "play.mp3", ofType:nil)
            else { return }
        let url = URL(fileURLWithPath: path)

        do {
            backgroundSound = try AVAudioPlayer(contentsOf: url)
            backgroundSound?.numberOfLoops = 2
            backgroundSound?.play()
        } catch {
            print(error.localizedDescription)
        }
    }

    func stopAudio() {
        if currentIndex == (viewModel.messageText.count-2) {
            backgroundSound?.setVolume(0.8, fadeDuration: 1.0)
        } else if currentIndex == viewModel.messageText.count {
            backgroundSound?.stop()
        }
    }

    func drawReplayButton() {
        if currentIndex == viewModel.messageText.count {
            let replayButton = UIButton()

            replayButton.backgroundColor = UIColor.darkGray
            replayButton.frame = CGRect(x: 150,
                                        y: 460,
                                        width: 80,
                                        height: 30)

            replayButton.layer.cornerRadius = 5
            replayButton.setTitle("Replay slides", for: .normal)
            replayButton.titleEdgeInsets = UIEdgeInsetsMake(10,10,15,10)
            replayButton.titleLabel?.adjustsFontSizeToFitWidth = true

            replayButton.center.x = self.view.frame.width + 30

            UIView.animate(withDuration: 1.0,
                           delay: 0,
                           usingSpringWithDamping: 1.0,
                           initialSpringVelocity: 6.0,
                           options: .curveEaseIn, animations: ({
                replayButton.center.x = self.view.frame.width / 2

            }), completion: nil)

            replayButton.addTarget(self, action: #selector(replayButtonPressed), for: .touchUpInside)

            replayButton.tag = 13
            view.addSubview(replayButton)
        }
    }

    @objc
    func replayButtonPressed() {
        if let replayViewWithTag = view.viewWithTag(13) {
            currentIndex = 0
            currentSlide?.removeFromSuperview()
            replayViewWithTag.removeFromSuperview()
            presentFirstSlide()
            playAudio()
            screenTimer = Timer.scheduledTimer(withTimeInterval: 9,
                                               repeats: true) { [weak self] _ in
                                                self?.presentNextSlide()
                                                self?.drawReplayButton()
                                                self?.stopAudio()
            }
        }
    }
}

class LaunchScreenView: UIView {
    var instructionText: String!
    var launchContent: String!
    var starString: String!

    init(frame: CGRect,
         launchContent: String,
         instructionText: String,
         starString: String) {

        super.init(frame: frame)
        self.instructionText = instructionText
        self.launchContent = launchContent
        self.starString = starString
        setupLaunchView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupLaunchView() {
        guard
            let star = UIImage(named: starString)
            else { return  }

        let attributedString = NSMutableAttributedString(string: launchContent)

        let instructionLabel = UILabel(frame: CGRect(x: frame.origin.x + 20,
                                                     y: frame.origin.y + 300,
                                                     width: frame.width - 40,
                                                     height: frame.height * 0.4))

        let headerLabel = UILabel(frame: CGRect(x: frame.origin.x + 10,
                                                y: frame.origin.y + 30,
                                                width: frame.width - 35,
                                                height: frame.height * 0.28))

        let paragraphStyle = NSMutableParagraphStyle()

        let starImageView = UIImageView(frame: CGRect(x: 164,
                                                      y: 600,
                                                      width: frame.width - 327,
                                                      height: frame.height - 624))

        let view = UIView(frame: CGRect(x: frame.origin.x + 15,
                                        y: frame.origin.y + 30,
                                        width: frame.width - 30,
                                        height: frame.height * 0.28))


        attributedString.addAttribute(NSAttributedStringKey.paragraphStyle,
                                      value:paragraphStyle,
                                      range:NSMakeRange(0, attributedString.length))

        paragraphStyle.lineSpacing = 2

        instructionLabel.contentMode = .scaleAspectFill
        instructionLabel.font = UIFont.boldSystemFont(ofSize: 24)
        instructionLabel.lineBreakMode = .byTruncatingTail
        instructionLabel.numberOfLines = 0
        instructionLabel.text = instructionText
        instructionLabel.textAlignment = .center
        instructionLabel.textColor = UIColor.white
        instructionLabel.sizeToFit()

        headerLabel.attributedText = attributedString
        headerLabel.contentMode = .scaleAspectFill
        headerLabel.font = UIFont.systemFont(ofSize: 19.0)
        headerLabel.lineBreakMode = .byTruncatingTail
        headerLabel.numberOfLines = 4
        headerLabel.textAlignment = .center
        headerLabel.textColor = UIColor.orange
        headerLabel.sizeToFit()

        view.backgroundColor = UIColor.white
        view.layer.masksToBounds = false
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize.zero
        view.layer.shadowOpacity = 1
        view.layer.shadowRadius = 10
        view.layer.shadowPath = UIBezierPath(rect: view.bounds).cgPath

        starImageView.image = star

        view.addSubview(headerLabel)
        addSubview(view)
        addSubview(instructionLabel)
        addSubview(starImageView)
    }
}


class ScreenView: UIView {

    var headerText: String!
    var headerTextLabel: UILabel!
    var messageContent: String!
    var messageLabel: UILabel!
    var screenImage: UIImage!
    var screenImageView: UIImageView!
    var starImage: UIImage!
    var starImageView: UIImageView!

    init(frame: CGRect,
         headerText: String,
         message: String,
         screenImage: UIImage,
         starImage: UIImage,
         starCount: Int) {
        super.init(frame: frame)

        self.headerText = headerText
        self.messageContent = message
        self.screenImage = screenImage
        self.starImage = starImage
        setLayout()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setLayout() {
        headerTextLabel = UILabel(frame: CGRect(x: frame.origin.x + 10,
                                                y: frame.origin.y + 15,
                                                width: frame.size.width - 20, height: frame.size.height * 1.1))

        messageLabel = UILabel(frame: CGRect(x: frame.origin.x + 18,
                                             y: frame.size.height * 0.5 + 70,
                                             width: frame.size.width - 18, height: frame.height * 1.5))

        screenImageView = UIImageView(frame: CGRect(x: frame.origin.x,
                                                    y: frame.origin.y,
                                                    width: frame.width + 20,
                                                    height: frame.height * 0.5))

        starImageView = UIImageView(frame: CGRect(x: frame.width - 191,
                                                  y: frame.height + 52,
                                                  width: frame.width - 307,
                                                  height: frame.height - 504))


        headerTextLabel.font = UIFont.boldSystemFont(ofSize: 22.0)
        headerTextLabel.lineBreakMode = .byTruncatingTail
        headerTextLabel.numberOfLines = 1
        headerTextLabel.text = headerText
        headerTextLabel.textAlignment = .center
        headerTextLabel.textColor = #colorLiteral(red: 0.949, green: 0.788, blue: 0.298, alpha: 1)

        messageLabel.font = UIFont(name: "Roboto-Regular", size: 14)
        messageLabel.lineBreakMode = .byTruncatingTail
        messageLabel.numberOfLines = 8
        messageLabel.text = messageContent
        messageLabel.textAlignment = .natural
        messageLabel.textColor = UIColor.white
        messageLabel.sizeToFit()

        screenImageView.contentMode = .scaleAspectFill
        screenImageView.image = screenImage

        starImageView.image = starImage

        addSubview(screenImageView)
        addSubview(headerTextLabel)
        addSubview(messageLabel)
        addSubview(starImageView)
    }

    func startAnimating() {

        let pulsate = CABasicAnimation(keyPath: "transform.scale")

        UIView.animate(withDuration: 0.9,
                       delay: 0.2,
                       options: .curveEaseInOut,
                       animations: {

            pulsate.autoreverses = true
            pulsate.fromValue = 1.0
            pulsate.toValue = 1.1
            pulsate.repeatCount = 1.0
            pulsate.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            self.headerTextLabel.layer.add(pulsate, forKey: "pulsate")
        }, completion: nil)

        UIView.animate(withDuration: 0.9,
                       delay: 0.4,
                       options: .curveEaseInOut,
                       animations: {
                        
            self.messageLabel.transform = .init(scaleX: 1.0, y: 0.9)
        }, completion: nil)

        UIView.animate(withDuration: 1.0,
                       animations: {

            self.starImageView.transform = CGAffineTransform(rotationAngle: .pi)
        }) { _ in

            pulsate.autoreverses = true
            pulsate.fromValue = 0.8
            pulsate.toValue = 1.5
            pulsate.repeatCount = Float.infinity
            pulsate.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)

            self.starImageView.layer.add(pulsate, forKey: "pulsating")
        }
    }
}

PlaygroundPage.current.liveView = StorySlides()

