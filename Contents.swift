import AVFoundation
import PlaygroundSupport
import UIKit

struct StorySlidesViewModel {
    let headerText: [String]
    let imageString: [String]
    let messageText: [String]
    let starImage: String

    init() {
        self.headerText = ["Story about us", "In the beginning", "Andela derived from Mandela", "It's Competition", "Talented People", "Amazing Andelans", "Empowerment for Leadership", "I am Andelan; iOS developer", "#TIA == Wakanda"]

        self.imageString = ["BlackPanther", "Beginning", "Mandela", "Competition", "Idea", "AmazingPeople", "Empowerment", "Samuel", "Andela"]

        self.messageText = ["It's not just a movie; it's a movement. It's a story about a people whose voice has been faint; endowed with great tech skills. It's Wakanda; Andela is recreating the virtual Wakanda to reality. Andela is preparing and repositioning future tech leaders.", "Andela was founded in September 2014 to build a network of tech leaders in Africa to bridge the gap between U.S and African tech sectors.", "Across the world brilliance is evenly distributed but opportunity is not. A quote by Andela CEO, Jeremy Johnson", "Andela is a competitive four years paid fellowship program that trains top software talents and on-boards into long distance business engagement with big companies", "There’s extraordinary untapped talent out there; We just need to remove the barriers to help talented young launch carriers without debt and without leaving home. Quote by Christina Sass, Andela President.", "Andelan’s are amazing people with great culture and mindset of changing the world through tech.", "Andela is not a brain drain program; It bridges skill gap and empowers youths for leadership.", "I love learning new things. I have great interest in security and cryptography. I am exploring and I love sharing what I have learned to the community.", "This Is Andela. The Wakanda of Africa. The future belongs to us."]

        self.starImage = "Star"
    }

}


public class StorySlides : UIViewController {

    var backgroundSound: AVAudioPlayer?
    var currentIndex = 0
    var screenTimer: Timer?
    var starTimer: Timer?
    var viewModel: StorySlidesViewModel!

    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.9651797414, green: 0.6645704508, blue: 0.358951211, alpha: 1)
        viewModel = StorySlidesViewModel()
//        play()
    }

    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        presentFirstSlide()
        screenTimer = Timer.scheduledTimer(withTimeInterval: 4,
                                           repeats: true) { [weak self] _ in
                                            self?.presentNextSlide()
        }

//        starTimer = Timer.scheduledTimer(withTimeInterval: 0.4,
//                                         repeats: true) { [weak self] _ in
//                                            self?.presentStarView()
//        }

    }


    public override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        screenTimer?.invalidate()
    }

//    func presentStarView() {
//
//        guard let star = UIImage(named: viewModel.starImage)
//            else { return }
//
//        let starImageView = UIImageView(frame: CGRect(x: 164,
//                                                      y: 618,
//                                                      width: 48,
//                                                      height: 44))
//        starImageView.image = star
//        UIView.animate(withDuration: 0.1) {
//            starImageView.transform = CGAffineTransform(rotationAngle: 90)
//            self.view.addSubview(starImageView)
//        }
//    }

    func presentFirstSlide() {
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

        if currentIndex > 0 {
            print("I am here")
            slide.removeFromSuperview()
        }

        slide.transform = CGAffineTransform(translationX: view.frame.width, y: 0)

        view.addSubview(slide)

        UIView.animate(withDuration: 0.25) {
            slide.transform = .identity
        }
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
                          message: messageText,
                          headerText: headerText,
                          screenImage: image,
                          starImage: star)
    }

    func play() {
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
}


class ScreenView: UIView {

    var messageContent: String!
    var headerText: String!
    var screenImage: UIImage!
    var starImage: UIImage!

    init(frame: CGRect, message: String, headerText: String, screenImage: UIImage, starImage: UIImage) {
        super.init(frame: frame)

        self.messageContent = message
        self.headerText = headerText
        self.screenImage = screenImage
        self.starImage = starImage
        setLayout()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setLayout() {
        let headerTextLabel = UILabel(frame: CGRect(x: 50,
                                                    y: 16,
                                                    width: frame.size.width * 0.7, height: frame.size.height * 1.1))

        let messageLabel = UILabel(frame: CGRect(x: 18,
                                                 y: 18,
                                                 width: frame.size.width - 18, height: frame.height * 1.5))

        let screenImageView = UIImageView(frame: CGRect(x: frame.origin.x,
                                                        y: frame.origin.y,
                                                        width: 375,
                                                        height: frame.height * 0.5))
        let starImageView = UIImageView(frame: CGRect(x: 164,
                                                      y: 618,
                                                      width: 48,
                                                      height: 44))
        headerTextLabel.text = headerText
        headerTextLabel.font = UIFont(name: "Roboto-Regular", size: 20)
        headerTextLabel.numberOfLines = 1
        headerTextLabel.textAlignment = .center
        headerTextLabel.textColor = #colorLiteral(red: 0.949, green: 0.788, blue: 0.298, alpha: 1)
        messageLabel.text = messageContent
        messageLabel.font = UIFont(name: "Roboto-Regular", size: 14)
        messageLabel.numberOfLines = 8
        messageLabel.textAlignment = .justified
        messageLabel.textColor = UIColor.white
        messageLabel.lineBreakMode = .byTruncatingTail
        screenImageView.image = screenImage
        screenImageView.contentMode = .scaleAspectFill
        starImageView.image = starImage

        headerTextLabel.tag = 1
        messageLabel.tag = 2
        screenImageView.tag = 3
        starImageView.tag = 4

        addSubview(screenImageView)
        addSubview(headerTextLabel)
        addSubview(messageLabel)
        addSubview(starImageView)

    }

    @objc class func rotateStar(imageView: UIImageView) {
        self.animate(withDuration: 1.0) {
            imageView.transform = CGAffineTransform(rotationAngle: 90)
        }
    }
}

PlaygroundPage.current.liveView = StorySlides()

