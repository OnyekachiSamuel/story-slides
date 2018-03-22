import AVFoundation
import PlaygroundSupport
import UIKit

struct StorySlidesViewModel {
    let headerText: [String]
    let imageString: [String]
    let messageText: [String]
    let starImage: String

    init() {
        self.headerText = ["Story about us", "In the beginning", "Andela derived from Mandela", "It's Competition", "Amazing Andelans", "Empowerment for Leadership", "I am Andelan; iOS developer", "#TIA == Wakanda"]

        self.imageString = ["BlackPanther", "Beginning", "Mandela", "Competition", "Idea", "AmazingPeople", "Empowerment", "Samuel", "Andela"]

        self.messageText = ["It's not just a movie; it's a movement. It's a story about a people whose voice has been faint; endowed with great tech skills. It's Wakanda; Andela is recreating the virtual Wakanda to reality. Andela is preparing and repositioning future tech leaders.", "Andela was founded in September 2014 to build a network of tech leaders in Africa to bridge the gap between U.S and African tech sectors.", "Across the world brilliance is evenly distributed but opportunity is not. A quote by Andela CEO, Jeremy Johnson", "Andela is a competitive four years paid fellowship program that trains top software talents and on-boards into long distance business engagement with big companies", "There’s extraordinary untapped talent out there; We just need to remove the barriers to help talented young launch carriers without debt and without leaving home. Quote by Christina Sass, Andela President.", "Andelan’s are amazing people with great culture and mindset of changing the world through tech.", "Andela is not a brain drain program; It bridges skill gap and empowers youths for leadership.", "I love learning new things. I have great interest in security and cryptography. I am exploring and I love sharing what I have learned to the community.", "This Is Andela. The Wakanda of Africa. The future belongs to us."]

        self.starImage = "Star"
    }

}


public class StorySlides : UIViewController {

    var backgroundSound: AVAudioPlayer?
    var screenTimer: Timer!
    var viewModel: StorySlidesViewModel!

    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.9651797414, green: 0.6645704508, blue: 0.358951211, alpha: 1)
        viewModel = StorySlidesViewModel()
        setupViews(viewModel: viewModel)
//        screenTimer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(ScreenView.rotateStar(imageView:)), userInfo: nil, repeats: true)
//                play()

    }

//    public override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        screenTimer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(ScreenView.rotateStar(imageView:)), userInfo: nil, repeats: true)
//    }

    public override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        screenTimer.invalidate()
    }

    @objc func updateUI(headerText: String, imageName: String, message: String, starImage: String) {

        guard let image = UIImage(named: imageName), let star = UIImage(named: starImage) else { return }
        let contentView = ScreenView(frame: CGRect(x: view.frame.origin.x,
                                                   y: view.frame.origin.y,
                                                   width: view.frame.width - 20,
                                                   height: view.frame.size.height - 120), message: message,
                                                                                          headerText: headerText, screenImage: image , starImage: star)

        view.addSubview(contentView)

    }

    func setupViews(viewModel: StorySlidesViewModel) {
        let headerText = viewModel.headerText
        let imageString = viewModel.imageString
        let messageText = viewModel.messageText
        let starImageString = viewModel.starImage

        for index in 0..<headerText.count {
            if index == 0, let image = UIImage(named: imageString[index]), let star = UIImage(named: starImageString) {

                print("I got here")

                let contentView = ScreenView(frame: CGRect(x: view.frame.origin.x,
                                                           y: view.frame.origin.y,
                                                           width: view.frame.width - 20,
                                                           height: view.frame.size.height - 120), message: messageText[index], headerText: headerText[index], screenImage: image , starImage: star)

                view.addSubview(contentView)
            } else {

                print("I am here")

//                updateUI(headerText: headerText[index], imageName: imageString[index], message: messageText[index], starImage: starImageString)

            }
        }

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
        let headerTextLabel = UILabel(frame: CGRect(x: 5,
                                                    y: 14,
                                                    width: frame.size.width - 420, height: frame.size.height - 300))

        let messageLabel = UILabel(frame: CGRect(x: 15,
                                                 y: 15,
                                                 width: frame.size.width - 420, height: frame.height - 100))

        let screenImageView = UIImageView(frame: CGRect(x: frame.origin.x,
                                                        y: frame.origin.y,
                                                        width: 375,
                                                        height: frame.height * 0.28))
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
        ScreenView.rotateStar(imageView: starImageView)

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

