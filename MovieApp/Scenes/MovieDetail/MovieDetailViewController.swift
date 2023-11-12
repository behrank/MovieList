//
//  MovieDetailViewController.swift
//  MovieApp
//
//  Created by Can Behran Kankul on 12.11.2023.
//

import Foundation
import UIKit

class MovieDetailViewController: UIViewController {
    
    private var movieImage: UIImage?
    private var onDismissCallback: (()->Void)?
    
    init(movieImage: UIImage? = nil, 
         dismissCallback: (()->Void)?) {
        self.movieImage = movieImage
        self.onDismissCallback = dismissCallback
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupScrollView()
        setupContainerView()
        setupStackView()
        setupMovieImageView()
        setupTitle()
        
        setupBackButton()
    }
    
    override func viewIsAppearing(_ animated: Bool) {
        super.viewIsAppearing(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    // MARK: - UI Generation
    lazy private var scrollView: UIScrollView = {
        let scroll = UIScrollView(frame: .zero)
        scroll.contentInset = .init(top: 0, left: 0, bottom: 0, right: 0)
        scroll.showsVerticalScrollIndicator = false
        scroll.showsHorizontalScrollIndicator = false
        scroll.contentInsetAdjustmentBehavior = UIScrollView.ContentInsetAdjustmentBehavior.never

        return scroll
    }()
    
    private func setupScrollView() {
        view.addSubviews(views: scrollView)
        scrollView.fillSuperview()
    }
    
    lazy private var containerView: UIView = {
        return UIView(frame: .zero)
    }()
    
    private func setupContainerView() {
        scrollView.addSubviews(views: containerView)
        containerView.fillSuperview()
        scrollView.backgroundColor = .red
    }
    
    lazy private var stackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.axis = .vertical
        stackView.spacing = 0
        
        return stackView
    }()
    
    private func setupStackView() {
        containerView.addSubviews(views: stackView)
        stackView.fillSuperview()
    }
    
    lazy private var backButton: UIButton = {
        let btn = UIButton(frame: .zero)
        btn.setImage(UIImage(named: "cancel"), for: .normal)
        btn.setImage(UIImage(named: "cancel"), for: .highlighted)
        btn.setImage(UIImage(named: "cancel"), for: .selected)
        return btn
    }()
    
    private func setupBackButton() {
        view.addSubviews(views: backButton)
        backButton.setMargins(.left(value: 16), .top(value: 48))
        backButton.addTarget(self,
                             action: #selector(userTappedBackBtn), for: .touchUpInside)
    }
    
    @objc private func userTappedBackBtn() {
        
        self.view.isHidden = true
        
        dismiss(animated: false) {
            self.onDismissCallback?()
            self.onDismissCallback = nil
        }
    }
    
    // MARK: - Content Generation
    lazy private var movieImageView: UIImageView = {
       return UIImageView(image: movieImage)
    }()
    
    private func setupMovieImageView() {
        stackView.addArrangedSubview(movieImageView)
        movieImageView.setWidth(view.frame.width)
        movieImageView.setHeight((view.frame.width/2)*3)
    }
    
    lazy private var titleLabel: UILabel = {
        return UILabel(frame: .zero)
    }()
    
    private func setupTitle() {
        stackView.addArrangedSubview(titleLabel)
        titleLabel.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. In sit amet hendrerit nisi. Vivamus at ligula ut dolor pulvinar lobortis sit amet eu ante. Nullam pellentesque ante id urna pharetra facilisis. Aenean quis accumsan tortor. Maecenas tincidunt ut odio non ornare. Suspendisse fringilla vehicula tempus. Aenean eu congue justo. Aenean sollicitudin justo leo, ut pulvinar tortor dictum at. Maecenas fermentum et orci a placerat. Vivamus pharetra enim sit amet feugiat pretium. Fusce vitae nulla rhoncus, ultrices lorem nec, dignissim turpis. Curabitur maximus velit quis ultrices lobortis. Fusce sed accumsan est. Morbi eget lacus sed elit mollis volutpat. Aliquam at elit nec turpis tincidunt consectetur eget nec magna.\nDuis sed turpis ex. Quisque et nulla at nisl tempus elementum sit amet quis ante. Aenean arcu elit, porta rutrum velit at, elementum imperdiet libero. Vestibulum eleifend enim vitae tellus auctor, sed luctus ipsum posuere. Donec dapibus ultricies odio, quis auctor enim accumsan et. Suspendisse tortor turpis, laoreet aliquet dignissim id, commodo et metus. Sed at nisi sed purus sollicitudin pulvinar et ac nunc. Duis ornare lacus at eleifend volutpat. Nulla blandit molestie vulputate. Nam ac dictum lorem. Sed condimentum, diam sit amet molestie convallis, nunc velit imperdiet eros, at finibus odio ipsum in nibh. Nulla tellus magna, condimentum a felis vel, congue varius ipsum. Aliquam ut lacus quis erat tincidunt dignissim. In id leo ullamcorper ipsum vulputate molestie non in nisl. Donec vel diam dui. Ut varius sodales feugiat."
        titleLabel.textColor = .white
        titleLabel.numberOfLines = 0
    }
}
