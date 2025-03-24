import UIKit

final class ArticleCell: UITableViewCell {
    enum Constants {
        static let identifier = "cell"
        static let shimmerFrame: CGRect = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 200)
    }
    
    private let articleImageView: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.clipsToBounds = true
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let announceLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.lineBreakMode = .byTruncatingTail
        label.font = UIFont.systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let shimmer: ShimmerView = ShimmerView(frame: Constants.shimmerFrame)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with article: Models.ArticleModel) {
        titleLabel.text = article.title
        announceLabel.text = article.announce
        
        if let imageUrl = article.img?.url {
            loadImage(from: imageUrl)
        } else {
            articleImageView.image = nil
        }
    }
    
    private func setupViews() {
        contentView.clipsToBounds = false
        contentView.addSubview(articleImageView)
        contentView.addSubview(announceLabel)
        contentView.addSubview(titleLabel)
        contentView.addSubview(shimmer)
        configureShimmer()
    }
    
    private func setupConstraints() {
        // Image
        articleImageView.pinTop(to: contentView.topAnchor)
        articleImageView.pinLeft(to: contentView.leadingAnchor)
        articleImageView.pinRight(to: contentView.trailingAnchor)
        
        articleImageView.setHeight(200)
        
        // Title
        titleLabel.pinTop(to: articleImageView.bottomAnchor, 8)
        titleLabel.pinLeft(to: contentView.leadingAnchor, 16)
        titleLabel.pinRight(to: contentView.trailingAnchor, 16)
        
        // Announce
        announceLabel.pinTop(to: titleLabel.bottomAnchor, 4)
        announceLabel.pinLeft(to: contentView.leadingAnchor, 16)
        announceLabel.pinRight(to: contentView.trailingAnchor, 16)
        
        announceLabel.pinBottom(to: contentView.bottomAnchor, 8)
    }
    
    private func loadImage(from url: URL) {
        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let self = self, let data = data, error == nil else { return }
            
            DispatchQueue.main.async {
                self.shimmer.isHidden = true
                self.articleImageView.image = UIImage(data: data)
            }
        }.resume()
    }
    
    private func configureShimmer() {
        shimmer.translatesAutoresizingMaskIntoConstraints = false
        shimmer.startAnimating()
    }
}
