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
        self.headerText = ["Story about us", "In the beginning", "Andela derived from Mandela", "The Funding", "It's Competition", "Talented People", "The Hackathon", "Amazing Andelans", "The Visit", "Empowerment for Leadership", "Partnership", "I am Andelan; iOS developer", "#TIA == Wakanda"]

        self.imageString = ["BlackPanther", "Beginning", "Mandela", "Funding", "Competition", "Idea", "Hackathon", "AmazingPeople", "Visit", "Empowerment", "Partnership", "Samuel", "Andela"]

        self.instructionText = "Do you want to embark on the tour? If so, click on the button below."

        self.launchScreenViewHeaderText = "You are about to watch the story slides of great minds in Africa who are passionate about changing the world through technology."

        self.messageText = ["It's not just a movie; it's a movement. It's a story about a people whose voice has been faint; endowed with great tech skills. It's Wakanda; Andela is recreating the virtual Wakanda to reality. Andela is preparing and repositioning future tech leaders.", "Andela was founded in September 2014 to build a network of tech leaders in Africa to bridge the gap between U.S and African tech sectors.", "Across the world brilliance is evenly distributed but opportunity is not. A quote by Andela CEO, Jeremy Johnson.", "Andela raised $24 million from Mark Zuckerberg and Priscilla Chan’s Fund to train African engineers.", "Andela is a competitive four years paid fellowship program that trains top software talents and on-boards into long distance business engagement with big companies.", "There’s extraordinary untapped talent out there; We just need to remove the barriers to help talented young launch carriers without debt and without leaving home. Quote by Christina Sass, Andela President.", "Andela team winning Saucecode 2018 Hackathon competition. Gaining admission tickets to facebook’s f8 dev conference 2108 at California, USA. Andelans are pacemakers.", "Andelan’s are amazing people with great culture and mindset of changing the world through tech.", "Mark Zuckerberg came to Lagos, Nigeria, in part to meet Andela, a startup he is backing. He was warmly welcomed by Andelans who were glad to have him around in the office.", "Andela is not a brain drain program; It bridges skill gap and empowers youths for leadership.", "Google Africa currently partnered with Andela and Udacity to provide 15,000 scholarships to developers in Africa as a way of giving back to the developer ecosystem. This will increase Andela learning community influence.", "I love learning new things. I have great interest in security and cryptography. I am exploring and I love sharing what I have learned to the community.", "This Is Andela. The Wakanda of Africa. The future belongs to us."]

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
        slide.transform = CGAffineTransform(translationX: 0, y: view.frame.height)

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
        slide.transform = CGAffineTransform(translationX: 0, y: -view.frame.height)

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
        pulse.repeatCount = 1000000
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

        tourButton.addTarget(self, action: #selector(StorySlides.tourButtonPressed(_:)), for: .touchUpInside)

        launchScreen.tag = 10
        tourButton.tag = 12

        view.addSubview(launchScreen)
        view.addSubview(tourButton)
    }

    @objc
    func tourButtonPressed(_ sender: UIButton) {
        if let launchScreenViewViewWithTag = view.viewWithTag(10),
            let tourButtonViewWithTag = view.viewWithTag(12) {
            launchScreenViewViewWithTag.removeFromSuperview()
            tourButtonViewWithTag.removeFromSuperview()
        }

        presentFirstSlide()
        playAudio()
        screenTimer = Timer.scheduledTimer(withTimeInterval: 8,
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
            screenTimer = Timer.scheduledTimer(withTimeInterval: 8,
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
        instructionLabel.numberOfLines = 3
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
        messageLabel.textAlignment = .justified
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

        UIView.animate(withDuration: 0.9,
                       delay: 0.4,
                       options: .curveEaseOut,
                       animations: {
                        
            self.messageLabel.transform = .init(scaleX: 1.0, y: 0.9)
        }, completion: nil)

        UIView.animate(withDuration: 1.0,
                       animations: {

            self.starImageView.transform = CGAffineTransform(rotationAngle: .pi)
        }) { _ in
            let animation = CABasicAnimation(keyPath: "transform.scale")

            animation.autoreverses = true
            animation.fromValue = 0.8
            animation.toValue = 1.5
            animation.repeatCount = Float.infinity
            animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)

            self.starImageView.layer.add(animation, forKey: "pulsating")
        }
    }
}

PlaygroundPage.current.liveView = StorySlides()

