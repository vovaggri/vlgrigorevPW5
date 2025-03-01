import UIKit

final class ArticleCell: UITableViewCell {
    enum Constants {
        static let identifier = "cell"
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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with article: Models.ArticleModel) {
        titleLabel.text = article.title
        
        if let imageUrl = article.img?.url {
            loadImage(from: imageUrl)
        } else {
            articleImageView.image = nil
        }
    }
    
    private func setupViews() {
        contentView.addSubview(articleImageView)
//        contentView.addSubview(announceLabel)
        contentView.addSubview(titleLabel)
    }
    
    private func setupConstraints() {
        articleImageView.pinTop(to: contentView.topAnchor)
        articleImageView.pinBottom(to: contentView.bottomAnchor)
        articleImageView.pinLeft(to: contentView.leadingAnchor)
        articleImageView.pinRight(to: contentView.trailingAnchor)
        
        titleLabel.pinLeft(to: contentView.leadingAnchor, 16)
        titleLabel.pinRight(to: contentView.trailingAnchor, 16)
        titleLabel.pinBottom(to: contentView.bottomAnchor, 16)
    }
    
    private func loadImage(from url: URL) {
        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let self = self, let data = data, error == nil else { return }
            
            DispatchQueue.main.async {
                self.articleImageView.image = UIImage(data: data)
            }
        }
    }
}
